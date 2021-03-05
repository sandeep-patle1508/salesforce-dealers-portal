module Salesforce
  module MockRestforceCollectionHelper
    def build_restforce_collection
      data_arr.map(&method(:build_restforce_object))
    end

    def build_restforce_object(data)
      Restforce::SObject.new(data)
    end

    def data_arr
      [
        {
          'Id' => '1111',
          'Name' => 'Berlin Account',
          'POS_Street__c' => 'Mitte',
          'POS_City__c' => 'Berlin',
          'POS_ZIP__c' => '10999',
          'POS_Country__c' => 'Germany',
          'POS_State__c' => 'Berlin',
          'POS_Phone__c' => '123456789',
          'Dealer_Latitude__c' => 52.5373,
          'Dealer_Longitude__c' => 13.3603
        },
        {
          'Id' => '2222',
          'Name' => 'Frankfurt Account',
          'POS_Street__c' => 'am Main',
          'POS_City__c' => 'Frankfurt',
          'POS_ZIP__c' => '60488',
          'POS_Country__c' => 'Germany',
          'POS_State__c' => 'Frankfurt',
          'POS_Phone__c' => '987654321',
          'Dealer_Latitude__c' => 50.110924,
          'Dealer_Longitude__c' => 8.682127
        },
        {
          'Id' => '3333',
          'Name' => 'Hamburg Account',
          'POS_Street__c' => 'Hamburg-Mitte',
          'POS_City__c' => 'Hamburg',
          'POS_ZIP__c' => '20457',
          'POS_Country__c' => 'Germany',
          'POS_State__c' => 'Hamburg',
          'POS_Phone__c' => '999999999',
          'Dealer_Latitude__c' => 53.5511,
          'Dealer_Longitude__c' => 9.9937
        }
      ]
    end
  end
end
