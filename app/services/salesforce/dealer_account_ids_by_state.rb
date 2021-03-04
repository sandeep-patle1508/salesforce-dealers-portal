# frozen_string_literal: true

module Salesforce
  class DealerAccountIdsByState
    def initialize(remote_dealer_account_ids:, local_dealer_account_ids:)
      @remote_dealer_account_ids = remote_dealer_account_ids
      @local_dealer_account_ids = local_dealer_account_ids
    end

    def call
      {
        new_dealer_account_ids: new_dealer_account_ids,
        deleted_dealer_account_ids: deleted_dealer_account_ids,
        existing_dealer_account_ids: existing_dealer_account_ids
      }
    end

    private

    attr_reader :remote_dealer_account_ids, :local_dealer_account_ids

    def new_dealer_account_ids
      remote_dealer_account_ids - local_dealer_account_ids
    end

    def deleted_dealer_account_ids
      local_dealer_account_ids - remote_dealer_account_ids
    end

    def existing_dealer_account_ids
      local_dealer_account_ids & remote_dealer_account_ids
    end

  end
end
