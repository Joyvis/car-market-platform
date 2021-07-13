# frozen_string_literal: true

module Users
  module ListRecommendedCarsSteps
    class Filter
      include Interactor

      delegate :brand_name, :price_min, :price_max, :page, to: :context

      def call
        context.cars = Car.includes(:brand).page(page || 1).per(20)
        context.cars = filter_by_brand(context.cars)
        context.cars = filter_by_price(context.cars)
      end

      private

      def filter_by_brand(cars)
        if brand_name.present?
          return cars.joins(:brand)
                     .where('brands.name LIKE ?', "%#{brand_name}%")
        end

        cars
      end

      def filter_by_price(cars)
        cars = cars.where('price >= ?', price_min) if price_min.present?

        cars = cars.where('price <= ?', price_max) if price_max.present?

        cars
      end
    end
  end
end
