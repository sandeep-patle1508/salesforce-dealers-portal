# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Salesforce::DeleteDealers do
  subject { described_class.new(dealer_account_ids) }

  let!(:local_dealer) { Fabricate(:dealer, account_id: '3333') }
  let(:dealer_account_ids) { [local_dealer.account_id] }

  it 'deletes dealers for requested account ids' do
    expect { subject.call }.
      to change { Dealer.exists?(account_id: '3333') }.
      from(true).to(false)
  end

  context 'when requested account ids array is empty' do
    let(:dealer_account_ids) { [] }

    it 'does not delete any records' do
      expect { subject.call }.not_to change { Dealer.count }.from(1)
    end
  end

  context 'when requested account ids more than one dealer id' do
    let!(:local_dealer_2) { Fabricate(:dealer, account_id: '4444') }
    let(:dealer_account_ids) { [local_dealer.account_id, local_dealer_2.account_id] }

    it 'delete both the records' do
      expect { subject.call }.
        to change { Dealer.exists?(account_id: '3333') }.
        from(true).to(false).
        and change { Dealer.exists?(account_id: '4444') }.
        from(true).to(false)
    end
  end
end
