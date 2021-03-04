# frozen_string_literal: true

module RestforceHelper
  def get_restforce_collection
    data_arr.map(&method(:build_restforce_object))
  end

  def build_restforce_object(data)
    Restforce::SObject.new(data)
  end

  def data_arr
    [
      {
        'Id' => '1111',
        'Name' => 'Test Account 1',
        'POS_Street__c' => 'Mitte',
        'POS_City__c' => 'Berlin',
        'POS_ZIP__c' => '10999',
        'POS_Country__c' => 'Germany',
        'POS_State__c' => 'Berlin',
        'POS_Phone__c' => '123456789',
        'Dealer_Latitude__c' => '52.5373',
        'Dealer_Longitude__c' => '13.3603'
      },
      {
        'Id' => '2222',
        'Name' => 'Test Account 2',
        'POS_Street__c' => 'Zoological',
        'POS_City__c' => 'Berlin',
        'POS_ZIP__c' => '10787',
        'POS_Country__c' => 'Germany',
        'POS_State__c' => 'Berlin',
        'POS_Phone__c' => '123456789',
        'Dealer_Latitude__c' => '52.5079',
        'Dealer_Longitude__c' => '13.3378'
      }
    ]
  end
end
