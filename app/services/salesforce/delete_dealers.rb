# frozen_string_literal: true

module Salesforce
  class DeleteDealers
    def initialize(dealer_account_ids)
      @dealer_account_ids = dealer_account_ids
    end

    def call
      dealers_to_delete.delete_all
    end

    private

    attr_reader :dealer_account_ids

    def dealers_to_delete
      Dealer.where(account_id: dealer_account_ids)
    end
  end
end
