# frozen_string_literal: true

module Users
  module ListRecommendedCarsSteps
    class Sort
      include Interactor

      delegate :cars, to: :context

      def call
        context.recommended_cars = perfect_match_cars
        context.recommended_cars += good_match_cars
        context.recommended_cars += best_rank_score_cars
        context.recommended_cars += other_cars
      end

      private

      def perfect_match_cars
        cars.select do |car|
          car.label == :perfect_match
        end
      end

      def good_match_cars
        (cars - context.recommended_cars).select do |car|
          car.label == :good_match
        end
      end

      def best_rank_score_cars
        (cars - context.recommended_cars)
          .sort_by { |car| car.rank_score || 0 }
          .reverse[0..4]
      end

      def other_cars
        (cars - context.recommended_cars)
          .sort_by { |car| car.price }
          .reverse
      end

      def label_car_ids(selected_label)
        labels.map do |label|
          label[:car_id] if label[:label] == selected_label
        end.compact
      end
    end
  end
end
