# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Salesforce::CompareAndUpdateDealers do
  subject do
    described_class.new(
      dealer_account_ids: dealer_account_ids,
      remote_dealers: remote_dealers,
      local_dealers: local_dealers
    )
  end

  let(:dealer_account_ids) { %w[1111] }
  let(:remote_dealers) { get_grouped_restforce_collection }
  let!(:local_dealer) { Fabricate(:dealer, name: account_name) }
  let(:local_dealers) { Dealer.all }

  context 'when local and remote has same data' do
    let(:account_name) { 'Test Account 1' }

    it 'does not update local dealer attributes' do
      expect{ subject.call }.not_to change { local_dealer.attributes }
    end
  end

  context 'when local dealer name is different from remote name' do
    let(:account_name) { 'Old Test Account 1' }

    it 'update name to remote name' do
      expect { subject.call }.
        to change { local_dealer.reload.name }.
        from('Old Test Account 1').to('Test Account 1')
    end
  end

  context 'when requested two account ids' do
    let(:dealer_account_ids) { %w[1111 2222] }

    context 'and only one is changed' do
      let(:account_name) { 'Test Account 1' }
      # change dealer record
      let!(:local_dealer_2) { Fabricate(:dealer, account_id: '2222', location_latitude: 62.5079) }

      it 'does not update first local dealer attributes' do
        expect{ subject.call }.not_to change { local_dealer.attributes }
      end

      it 'update latitude to remote latitude for second dealer' do
        expect { subject.call }.
          to change { local_dealer_2.reload.location_latitude }.
          from(62.5079).to(52.5079)
      end
    end

    context 'and both the dealers got changed' do
      let(:account_name) { 'Old Test Account 1' }
      let!(:local_dealer_2) { Fabricate(:dealer, account_id: '2222', location_longitude: 10.3378) }

      it 'update name to remote name' do
        expect { subject.call }.
          to change { local_dealer.reload.name }.
          from('Old Test Account 1').to('Test Account 1')
      end

      it 'update latitude to remote latitude for second dealer' do
        expect { subject.call }.
          to change { local_dealer_2.reload.location_longitude }.
          from(10.3378).to(13.3378)
      end
    end
  end
end
