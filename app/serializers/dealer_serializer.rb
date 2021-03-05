# frozen_string_literal: true

class DealerSerializer
  include FastJsonapi::ObjectSerializer
  attributes :account_id, :name, :pos_street, :pos_city, :pos_zip, :location_latitude, :location_longitude
end
