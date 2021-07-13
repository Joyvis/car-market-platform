# frozen_string_literal: true

class Users::UpdateCarRankScoreWorker
  include Sidekiq::Worker

  def perform(user_id)
    BravadoRecommendationExternalService
      .get_recommended_cars(user_id: user_id, update_redis: true)
  end
end
