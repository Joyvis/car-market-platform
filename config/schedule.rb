every 1.minute do
  runner "Users::ScheduleRankScoreUpdateWorker.perform_async", environment: 'development'
end
