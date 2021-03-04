module Salesforce
  module ConstantHelper
    COLUMNS_TO_COMPARE = {
      name: 'Name',
      pos_street: 'POS_Street__c',
      pos_city: 'POS_City__c',
      pos_zip: 'POS_ZIP__c',
      pos_country: 'POS_Country__c',
      pos_state: 'POS_State__c',
      pos_phone: 'POS_Phone__c',
      location_latitude: 'Dealer_Latitude__c',
      location_longitude: 'Dealer_Longitude__c'
    }.freeze

    LOCAL_REMOTE_COLUMN_MAPPINGS = COLUMNS_TO_COMPARE.merge(account_id: 'Id').freeze
  end
end
