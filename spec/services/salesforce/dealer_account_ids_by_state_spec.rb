# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Salesforce::DealerAccountIdsByState do
  subject do
    described_class.new(
      remote_dealer_account_ids: remote_dealer_account_ids,
      local_dealer_account_ids: local_dealer_account_ids
    )
  end

  let(:remote_dealer_account_ids) { %w[1111 2222] }
  let(:local_dealer_account_ids) { %w[1111] }
  let(:expected_account_ids_hash) do
    {
      new_dealer_account_ids: %w[2222],
      deleted_dealer_account_ids: [],
      existing_dealer_account_ids: %w[1111]
    }
  end

  it 'returns expected to hash with expected account ids' do
    expect(subject.call).to eq(expected_account_ids_hash)
  end

  context 'when one remote account is deleted' do
    let(:remote_dealer_account_ids) { %w[1111] }
    let(:local_dealer_account_ids) { %w[1111 2222] }
    let(:expected_account_ids_hash) do
      {
        new_dealer_account_ids: [],
        deleted_dealer_account_ids: %w[2222],
        existing_dealer_account_ids: %w[1111]
      }
    end

    it 'returns expected to hash with expected account ids' do
      expect(subject.call).to eq(expected_account_ids_hash)
    end
  end

  context 'when all the records are exists' do
    let(:remote_dealer_account_ids) { %w[1111 2222] }
    let(:local_dealer_account_ids) { %w[1111 2222] }
    let(:expected_account_ids_hash) do
      {
        new_dealer_account_ids: [],
        deleted_dealer_account_ids: %w[],
        existing_dealer_account_ids: %w[1111 2222]
      }
    end

    it 'returns expected to hash with expected account ids' do
      expect(subject.call).to eq(expected_account_ids_hash)
    end
  end
end
