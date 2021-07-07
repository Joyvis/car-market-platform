# frozen_string_literal: true

module Users
  class ListRecommendedCars
    include Interactor::Organizer

    organize ListRecommendedCarsSteps::Filter,
             ListRecommendedCarsSteps::AssignLabel,
             ListRecommendedCarsSteps::AssignExternalRankScore,
             ListRecommendedCarsSteps::Sort
  end
end
