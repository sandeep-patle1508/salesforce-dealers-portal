# frozen_string_literal: true

class Dealer < ApplicationRecord
  validates_presence_of :name
  validates :account_id, presence: true, uniqueness: true
end
