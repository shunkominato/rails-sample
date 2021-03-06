module Api
  module V1
    class LineFoodsController < ApplicationController
      before_action :set_food, only: %i[create replace]

      def index
        line_foods = LineFood.active
        p ")))))))))))))))))))))))))"
        aa = LineFood.active
        logger.debug(aa.inspect)
        p ")))))))))))))))))))))))))"
        if line_foods.exists?
          render json: {
            line_food_ids: line_foods.map { |line_food| line_food.id },
            restaurant: line_foods[0].restaurant,
            count: line_foods.sum { |line_food| line_food[:count] },
            amount: line_foods.sum { |line_food| line_food.total_amount },
          }, status: :ok
        else
          render json: {}, status: :no_content
        end
      end

      def create
        p "111111111111"
        p "--------------"
        aa = LineFood.active
        logger.debug(aa.inspect)
        p "--------------"
        if LineFood.active.other_restaurant(@ordered_food.restaurant.id).exists?
          p "2222222222"
          return render json: {
            existng_restaurant: LineFood.other_restaurant(@ordered_food.other_restaurant.id).first.restaurant.name,
            new_restaurant: Food.find(params[:food_id]).restaurant.name,
          }, status: :not_acceptable
        end

        p "33333333"
        set_line_food(@ordered_food)

        p "44444444444"
        if @line_food.save
          render json: {
            line_food: @line_food
          }, status: :created
        else
          render json: {}, status: :internal_server_error
        end
      end

      def replace
        LineFood.active.other_restaurant(@ordered_food.restaurant.id).each do |line_food|
          line_food.update_attribute(:active, false)
        end

        set_line_food(@ordered_food)

        if @line_food.save
          render json: {
            line_food: @line_food
          }, status: :created
        else
          render json: {},status: :internal_server_error
        end
      end



      private

      def set_food
        @ordered_food = Food.find(params[:food_id])
        p "--------------"
        logger.debug(@ordered_food.restaurant.inspect)
        p "--------------"
      end

      def set_line_food(ordered_food)

        if ordered_food.line_food.present?
          @line_food = ordered_food.line_food
          p "------@line_food.attributes--------"
          logger.debug(@line_food.inspect)
          p "--------------"
          @line_food.attributes = {
            count: ordered_food.line_food.count + params[:count],
            active: true
          }
        else
          @line_food = ordered_food.build_line_food(
            count: params[:count],
            restaurant: ordered_food.restaurant,
            active: true
          )
        end
      end
    end
  end
end