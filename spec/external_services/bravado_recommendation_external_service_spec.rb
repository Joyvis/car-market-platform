# frozen_string_literal: true

require 'rails_helper'

describe BravadoRecommendationExternalService, vcr: true do
  describe '.get_recommended_cars' do
    subject { described_class.get_recommended_cars(user_id: 1) }

    it 'returns an array of hashes' do
      is_expected.to be_a Array
      expect(subject.first.keys).to include(:car_id)
      expect(subject.first.keys).to include(:rank_score)
    end
  end
end
