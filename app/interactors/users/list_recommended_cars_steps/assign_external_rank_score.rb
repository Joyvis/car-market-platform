# frozen_string_literal: true

module Users
  module ListRecommendedCarsSteps
    class AssignExternalRankScore
      include Interactor

      delegate :user, :cars, to: :context

      def call
        context.cars = assign_rank_score_to_cars
      end

      private

      def assign_rank_score_to_cars
        cars.map do |car|
          car.rank_score = find_car_rank_score(car)

          car
        end
      end

      def find_car_rank_score(car)
        cars_with_rank_score
          .find { |car_rank| car_rank[:car_id] == car.id }.try(:[], :rank_score)
      end

      def cars_with_rank_score
        @cars_with_rank_score ||= ::BravadoRecommendationExternalService
          .get_recommended_cars(user_id: user.id)
      end
    end
  end
end
