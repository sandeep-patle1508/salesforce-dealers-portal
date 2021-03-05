# frozen_string_literal: true

class CreateDealers < ActiveRecord::Migration[6.0]
  def change
    create_table :dealers do |t|
      t.string :account_id, null: false, index: { unique: true }
      t.string :name, null: false
      t.string :pos_street
      t.string :pos_city
      t.string :pos_zip
      t.string :pos_country
      t.string :pos_state
      t.string :pos_phone
      t.float :location_latitude
      t.float :location_longitude

      t.timestamps
    end
  end
end
