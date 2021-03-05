# frozen_string_literal: true

module Api
  module V1
    class DealersController < ApplicationController
      def index
        dealers = Dealer.all

        render json: DealerSerializer.new(dealers).serialized_json
      end
    end
  end
end
