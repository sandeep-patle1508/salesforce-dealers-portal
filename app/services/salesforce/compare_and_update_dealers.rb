# frozen_string_literal: true

module Salesforce
  class CompareAndUpdateDealers
    include Salesforce::ConstantHelper

    def initialize(dealer_account_ids:, remote_dealers:, local_dealers:)
      @dealer_account_ids = dealer_account_ids
      @remote_dealers = remote_dealers
      @local_dealers = local_dealers
    end

    def call
      dealer_account_ids.each do |account_id|
        remote_record = remote_dealers[account_id]
        local_record = dealer_by_account_id(account_id)
        compare_and_update(remote_record, local_record)
      end
    end

    private

    attr_reader :dealer_account_ids, :remote_dealers, :local_dealers

    def compare_and_update(remote_record, local_record)
      changed_values = find_changed_values(remote_record, local_record)

      update_local_record(local_record, changed_values) unless changed_values.blank?
    end

    def find_changed_values(remote_record, local_record)
      COLUMNS_TO_COMPARE.reduce({}) do |memo, (local_col, remote_col)|
        if local_record[local_col] != remote_record[remote_col]
          memo[local_col] = remote_record[remote_col]
        end

        memo
      end
    end

    def dealer_by_account_id(account_id)
      Dealer.find_by(account_id: account_id)
    end

    def update_local_record(local_record, changed_values)
      local_record.update(changed_values)
    end
  end
end
