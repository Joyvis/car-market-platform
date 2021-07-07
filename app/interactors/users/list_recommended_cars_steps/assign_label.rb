# frozen_string_literal: true

module Users
  module ListRecommendedCarsSteps
    class AssignLabel
      include Interactor

      delegate :user, :cars, to: :context

      def call
        context.cars = assign_label_to_cars
      end

      private

      def assign_label_to_cars
        cars.map do |car|
          if perfect_match?(car)
            car.label = :perfect_match
          elsif good_match?(car)
            car.label = :good_match
          end

          car
        end
      end

      def perfect_match?(car)
        user.preferred_brands.include?(car.brand) &&
          user.preferred_price_range.include?(car.price)
      end

      def good_match?(car)
        user.preferred_brands.include?(car.brand)
      end
    end
  end
end
