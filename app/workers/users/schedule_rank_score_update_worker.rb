# frozen_string_literal: true

class Users::ScheduleRankScoreUpdateWorker
  include Sidekiq::Worker

  def perform
    User.all.each do |user|
      Users::UpdateCarRankScoreWorker.perform_async(user.id)
    end
  end
end
