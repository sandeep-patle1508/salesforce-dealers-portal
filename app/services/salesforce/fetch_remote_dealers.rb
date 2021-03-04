# frozen_string_literal: true

module Salesforce
  class FetchRemoteDealers
    extend Salesforce::ConstantHelper

    class << self
      def call
        dealers.reduce({}) do |memo, record|
          memo[record.Id] = record
          memo
        end
      end

      private

      def map_dealer(record)
        {
          record.Id => record
        }
      end

      def dealers
        api_client.query(query_string)
      end

      def api_client
        Salesforce::ApiClient.new
      end

      def query_string
        'SELECT ' +
          LOCAL_REMOTE_COLUMN_MAPPINGS.values.join(', ') +
          " FROM Account WHERE E_Shop_Dealer__c = 'Dealer and Point of Sale'"
      end
    end
  end
end
