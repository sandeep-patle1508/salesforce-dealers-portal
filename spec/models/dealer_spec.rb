# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dealer, type: :model do
  let(:base_object) { Fabricate.build(:dealer) }

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(base_object).to be_valid
    end

    it 'is not valid without a salesforce_account_id' do
      base_object.salesforce_account_id = nil
      expect(base_object).to_not be_valid
    end

    it 'is not valid without an name' do
      base_object.name = nil
      expect(base_object).to_not be_valid
    end

    it 'is not valid without an location_latitude' do
      base_object.location_latitude = nil
      expect(base_object).to_not be_valid
    end

    it 'is not valid without an location_latitude' do
      base_object.location_longitude = nil
      expect(base_object).to_not be_valid
    end
  end
end
