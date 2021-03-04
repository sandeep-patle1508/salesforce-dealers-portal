# frozen_string_literal: true

class Dealer < ApplicationRecord
  validates_presence_of :salesforce_account_id, :name, :location_latitude, :location_longitude
end
