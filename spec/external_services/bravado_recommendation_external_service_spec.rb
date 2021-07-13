# frozen_string_literal: true

require 'rails_helper'

describe BravadoRecommendationExternalService, vcr: true do
  describe '.get_recommended_cars' do
    let(:user_id) { 1 }
    let(:cached_response) { Redis.current.get("recommended_cars_#{user_id}") }
    subject { described_class.get_recommended_cars(user_id: user_id) }

    context 'when a cached response exists' do
      before do
        Redis.current.set("recommended_cars_#{user_id}", [{ foo: :bar }].to_json)
      end

      it 'returns the cached response' do
        expect(subject.first.keys).to include(:foo)
      end
    end

    context 'when cached response does not exist' do
      before do
        Redis.current.del("recommended_cars_#{user_id}")
      end

      it 'returns an array of hashes' do
        is_expected.to be_a Array
        expect(subject.first.keys).to include(:car_id)
        expect(subject.first.keys).to include(:rank_score)
      end

      it 'saves API response on Redis' do
        subject
        expect(cached_response).not_to be_nil
      end
    end
  end
end
