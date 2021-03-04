# frozen_string_literal: true

class CreateDealers < ActiveRecord::Migration[6.0]
  def change
    create_table :dealers do |t|
      t.string :salesforce_account_id, null: false, index: true
      t.string :name, null: false
      t.string :pos_street
      t.string :pos_city
      t.string :pos_zip
      t.string :pos_country
      t.string :pos_state
      t.string :pos_phone
      t.float :location_latitude, null: false
      t.float :location_longitude, null: false

      t.timestamps
    end
  end
end
