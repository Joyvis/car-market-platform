# frozen_string_literal: true

require 'rails_helper'

describe Users::ListRecommendedCarsSteps::Sort do
  describe 'sorting recommended cars' do
    subject do
      described_class.call(cars: cars)
    end

    let(:perfect_cars) do
      create_list(:car, 3) { |car| car.label = :perfect_match }
    end

    let(:good_cars) do
      create_list(:car, 3) { |car| car.label = :good_match }
    end

    let(:rank_score_cars) do
      create_list(:car, 5) do |car|
        rank_score = rand(0.5..0.9)
        car.rank_score = rank_score
      end
    end

    let(:other_cars) { create_list(:car, 4) }

    let(:cars) { rank_score_cars + perfect_cars + good_cars + other_cars }

    let(:sorted_ids) { subject.recommended_cars.map(&:id) }

    it 'returns perfect matches in the beggining of array' do
      expect(sorted_ids[0..2]).to include(perfect_cars[0].id)
      expect(sorted_ids[0..2]).to include(perfect_cars[1].id)
      expect(sorted_ids[0..2]).to include(perfect_cars[2].id)
    end

    it 'returns good matches after perfect matches' do
      expect(sorted_ids[3..5]).to include(good_cars[0].id)
      expect(sorted_ids[3..5]).to include(good_cars[1].id)
      expect(sorted_ids[3..5]).to include(good_cars[2].id)
    end

    it 'returns cars with good rank score after good matches' do
      expect(sorted_ids[6..10]).to include(rank_score_cars[0].id)
      expect(sorted_ids[6..10]).to include(rank_score_cars[1].id)
      expect(sorted_ids[6..10]).to include(rank_score_cars[2].id)
      expect(sorted_ids[6..10]).to include(rank_score_cars[3].id)
      expect(sorted_ids[6..10]).to include(rank_score_cars[4].id)
    end

    it 'returns the rest of the cars in the end of array' do
      expect(sorted_ids.size).to eq(cars.size)
    end
  end
end
