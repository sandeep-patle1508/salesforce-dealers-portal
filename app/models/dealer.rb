# frozen_string_literal: true

class Dealer < ApplicationRecord
  validates_presence_of :name, :location_latitude, :location_longitude
  validates :account_id, presence: true, uniqueness: true
end
