# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Salesforce::SyncDealers do
  subject { described_class.new }

  let(:api_client) { instance_double(Salesforce::ApiClient) }
  let(:restforce_collection) { get_restforce_collection }
  let(:sql) do
    "SELECT Name, POS_Street__c, POS_City__c, POS_ZIP__c, " \
    "POS_Country__c, POS_State__c, POS_Phone__c, Dealer_Latitude__c, " \
    "Dealer_Longitude__c, Id " \
    "FROM Account WHERE E_Shop_Dealer__c = 'Dealer and Point of Sale'"
  end

  let!(:local_dealer) { Fabricate(:dealer, account_id: '1111', name: 'Old Test Account 1') }
  let!(:remotely_deleted_dealer) { Fabricate(:dealer, account_id: '3333') }
  let(:expected_attributes_for_new_dealer) do
    {
      account_id: '2222',
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


  before do
    # mock api call to return restforce object collection
    allow(Salesforce::ApiClient).
      to receive(:new).and_return(api_client)

    allow(api_client).
      to receive(:query).with(sql).
      and_return(restforce_collection)
  end


  it 'create local dealer for this new remote dealer' do
    subject.call

    expect(Dealer.find_by(account_id: '2222')).
      to have_attributes(expected_attributes_for_new_dealer)
  end

  it 'deletes local dealer for tne deleted remote dealer' do
    expect { subject.call }.
      to change { Dealer.exists?(account_id: '3333') }.
      from(true).to(false)
  end

  it 'updates local dealer name as it got changed remotely' do
    expect { subject.call }.
      to change { local_dealer.reload.name }.
      from('Old Test Account 1').to('Test Account 1')
  end
end
