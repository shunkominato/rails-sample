module Api
  module V1
    class FoodsController < ApplicationController
      def index
        restaurant = Restaurant.find(params[:restaurant_id])

        render json: {
          foods: restaurant.foods
        }, status: :ok
      end
    end
  end
end