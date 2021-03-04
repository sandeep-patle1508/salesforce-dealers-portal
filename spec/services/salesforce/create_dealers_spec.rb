# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Salesforce::CreateDealers do
  subject do
    described_class.new(
      dealer_account_ids: dealer_account_ids,
      remote_dealers: remote_dealers
    )
  end

  let(:remote_dealers) { get_grouped_restforce_collection }
  let(:dealer_account_ids) { %w[2222] }
  let(:expected_attributes) do
    {
      name: 'Test Account 2',
      pos_street: 'Zoological',
      pos_city: 'Berlin',
      pos_zip: '10787',
      pos_country: 'Germany',
      pos_state: 'Berlin',
      pos_phone: '123456789',
      location_latitude: 52.5079,
      location_longitude: 13.3378
    }
  end

  it 'create new dealer record for requested account id' do
    expect { subject.call }.
      to change { Dealer.exists?(account_id: '2222') }.
      from(false).to(true)
  end

  it 'create new dealer record for requested account id' do
    subject.call

    expect(Dealer.find_by(account_id: '2222')).
      to have_attributes(expected_attributes)
  end

  context 'when no records to create' do
    let(:dealer_account_ids) { [] }

    it 'does not creates any records' do
      expect { subject.call }.not_to change { Dealer.count }.from(0)
    end
  end
end
