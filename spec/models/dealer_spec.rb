# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dealer, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:account_id) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:location_latitude) }
    it { should validate_presence_of(:location_longitude) }
  end

  it { is_expected.to have_db_index(:account_id) }
end
