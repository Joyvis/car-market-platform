# frozen_string_literal: true

require 'rails_helper'

describe Users::ListRecommendedCarsSteps::AssignExternalRankScore do
  describe 'assigning external rank score to cars' do
    before do
      allow(BravadoRecommendationExternalService)
        .to receive(:get_recommended_cars) { score_list }
    end

    subject { described_class.call(user: user, cars: cars).cars }

    let(:user) { create(:user) }
    let(:cars) { create_list(:car, 3) }
    let(:score_list) do
      [0.01, 0.5, 0.9].map.with_index do |score, index|
        { rank_score: score, car_id: cars[index].id }
      end
    end

    it 'returns an array' do
      expect(subject).to be_an Array
    end

    it 'returns an array of cars with rank score' do
      expect(subject.first.rank_score).to eq(0.01)
      expect(subject[1].rank_score).to eq(0.5)
      expect(subject[2].rank_score).to eq(0.9)
    end
  end
end
