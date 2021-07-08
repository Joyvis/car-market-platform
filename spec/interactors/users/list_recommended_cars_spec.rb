require 'rails_helper'

describe Users::ListRecommendedCars do
  describe 'listing recommended cars for a user' do
    before do
      allow(BravadoRecommendationExternalService)
        .to receive(:get_recommended_cars) { score_list }
    end

    let(:user) { create(:user, preferred_price_range: 1000..1500) }
    let(:brand) { create(:brand, name: 'GM') }
    let!(:user_preferred_brand) do
      create(:user_preferred_brand, user: user, brand: brand)
    end

    let!(:score_list) do
      [0.01, 0.5, 0.9, 0.7, 0.8].map.with_index do |score, index|
        { rank_score: score, car_id: no_match_cars[index].id }
      end
    end

    let!(:rank_score_cars) do
      create_list(:car, 5, price: 800)
    end

    let!(:perfect_cars) do
      create_list(:car, 3, price: 1010, brand: brand)
    end

    let!(:good_cars) do
      create_list(:car, 2, price: 900, brand: brand)
    end

    let!(:no_match_cars) do
      create_list(:car, 10, price: 600)
    end

    subject { described_class.call(user: user).recommended_cars }

    it 'returns a list of recommended cars' do
      is_expected.to be_an Array
    end

    it 'returns a list with perfect_match label cars in first' do
      expect(subject.first.label).to eq(:perfect_match)
    end

    it 'returns a list with the lowest price in last' do
      expect(subject.last.price).to eq(600)
    end
  end
end
