# frozen_string_literal: true

class BravadoRecommendationExternalService
  BASE_URL =
    'https://bravado-images-production.s3.amazonaws.com/recomended_cars.json'

  def self.get_recommended_cars(user_id:)
    params = { user_id: user_id }
    JSON.parse(
      RestClient.get(BASE_URL, params: params).body,
      symbolize_names: true
    )
  end
end
