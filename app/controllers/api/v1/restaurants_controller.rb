module Api
  module V1
    class RestaurantsController < ApplicationController
      def index
        restaurants = Restaurant.all
        # logger.debug restaurants.length
        render json: {
          restaurants: restaurants
        }, status: :ok
      end
    end
  end
end