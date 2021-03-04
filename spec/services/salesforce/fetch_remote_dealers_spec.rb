# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Salesforce::FetchRemoteDealers do
  let(:api_client) { instance_double(Salesforce::ApiClient) }
  let(:restforce_collection) { get_restforce_collection }
  let(:sql) do
    "SELECT Name, POS_Street__c, POS_City__c, POS_ZIP__c, " \
    "POS_Country__c, POS_State__c, POS_Phone__c, Dealer_Latitude__c, " \
    "Dealer_Longitude__c, Id " \
    "FROM Account WHERE E_Shop_Dealer__c = 'Dealer and Point of Sale'"
  end

  let(:expected_records) do
    {
      '1111' => restforce_collection.first,
      '2222' => restforce_collection.last
    }
  end

  before do
    allow(Salesforce::ApiClient).
      to receive(:new).and_return(api_client)

    allow(api_client).
      to receive(:query).with(sql).and_return(restforce_collection)
  end

  it 'returns array of hash records with account_id as key' do
    expect(described_class.call).to eq(expected_records)
  end
end
