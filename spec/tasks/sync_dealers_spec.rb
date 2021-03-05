# frozen_string_literal: true

require 'rails_helper'

Rails.application.load_tasks

RSpec.describe 'rake salesforce:sync_dealers', type: :task do

  let(:sync_dealers_service) { instance_double(Salesforce::SyncDealers) }

  it 'calls sync dealers service' do
    expect(Salesforce::SyncDealers).
      to receive(:new).and_return(sync_dealers_service)

    expect(sync_dealers_service).to receive(:call)

    Rake::Task['salesforce:sync_dealers'].invoke
  end
end
