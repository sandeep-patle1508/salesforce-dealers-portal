# frozen_string_literal: true

module Salesforce
  class CreateDealers
    include Salesforce::ConstantHelper

    def initialize(dealer_account_ids:, remote_dealers:)
      @dealer_account_ids = dealer_account_ids
      @remote_dealers = remote_dealers
    end

    def call
      dealer_account_ids.each(&method(:create_dealer))
    end

    private

    attr_reader :dealer_account_ids, :remote_dealers

    def create_dealer(account_id)
      remote_record = remote_dealers[account_id]
      dealer_attributes = prepare_dealer_attributes(remote_record)
      Dealer.create!(dealer_attributes)
    end

    def prepare_dealer_attributes(remote_record)
      LOCAL_REMOTE_COLUMN_MAPPINGS.reduce({}) do |memo, (local_col, remote_col)|
        memo[local_col] = remote_record[remote_col]
        memo
      end
    end
  end
end
