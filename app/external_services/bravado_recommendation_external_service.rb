# frozen_string_literal: true

class BravadoRecommendationExternalService
  class << self
    BASE_URL =
      'https://bravado-images-production.s3.amazonaws.com/recomended_cars.json'

    def get_recommended_cars(user_id:, update_redis: false)
      JSON.parse(
        cached_recommended_cars(user_id, update_redis),
        symbolize_names: true
      )
    end

    private

    def cached_recommended_cars(user_id, update_redis)
      redis = Redis.current
      recommended_cars = redis.get("recommended_cars_#{user_id}")

      if valid_json?(recommended_cars) &&
          recommended_cars.present? && !update_redis
        return recommended_cars
      end

      recommended_cars_from_api(user_id, redis)
    end

    def recommended_cars_from_api(user_id, redis)
      params = { user_id: user_id }
      recommended_cars = RestClient.get(BASE_URL, params: params).body
      redis.set("recommended_cars_#{user_id}", recommended_cars)

      recommended_cars
    rescue StandardError
      [{}].to_json
    end

    def valid_json?(json)
      JSON.parse(json)
      true
    rescue StandardError
      false
    end
  end
end
