# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Salesforce::ApiClient do
  subject { described_class.new }

  let(:restforce) { instance_double(Restforce::Data::Client) }
  let(:collection) { get_restforce_collection }
  let(:sql) { 'SELECT Id from Account' }

  before do
    allow(Restforce).
      to receive(:new).with(*any_args).and_return(restforce)

    allow(restforce).
      to receive(:query).with(*any_args).and_return(collection)
  end

  it 'calls Restforce client query method with requested sql' do
    expect(restforce).to receive(:query).with(sql)

    subject.query(sql)
  end

  it 'returns collection of Restforce objects' do
    expect(subject.query(sql)).to eq(collection)
  end
end
