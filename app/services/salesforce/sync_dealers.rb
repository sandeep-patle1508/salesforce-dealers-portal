# frozen_string_literal: true

module Salesforce
  class SyncDealers
    def call
      create_dealers(dealer_account_ids_by_state[:new_dealer_account_ids])
      delete_dealers(dealer_account_ids_by_state[:deleted_dealer_account_ids])
      check_and_update_dealers(dealer_account_ids_by_state[:existing_dealer_account_ids])
    end

    private

    def dealer_account_ids_by_state
      @dealer_account_ids_by_state ||= Salesforce::DealerAccountIdsByState.new(
        remote_dealer_account_ids: remote_dealers.keys,
        local_dealer_account_ids: local_dealers.pluck(:account_id)
      ).call
    end

    def remote_dealers
      @remote_dealers ||= Salesforce::FetchRemoteDealers.call
    end

    def local_dealers
      @local_dealers ||= Dealer.all
    end

    def create_dealers(dealer_account_ids)
      Salesforce::CreateDealers.new(
        dealer_account_ids: dealer_account_ids,
        remote_dealers: remote_dealers
      ).call
    end

    def delete_dealers(dealer_account_ids)
      Salesforce::DeleteDealers.new(dealer_account_ids).call
    end

    def check_and_update_dealers(dealer_account_ids)
      Salesforce::CompareAndUpdateDealers.new(
        dealer_account_ids: dealer_account_ids,
        remote_dealers: remote_dealers,
        local_dealers: local_dealers
      ).call
    end
  end
end
