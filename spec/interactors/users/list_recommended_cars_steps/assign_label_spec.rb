# frozen_string_literal: true

require 'rails_helper'

describe Users::ListRecommendedCarsSteps::AssignLabel do
  describe 'assigning a label to cars' do
    subject { described_class.call(user: user, cars: cars) }
    let(:user) { create(:user, preferred_price_range: 50..100) }
    let(:cars) { create_list(:car, 1) { |car| car.price = car_price } }

    context 'when car brand and price range match' do
      before do
        create(:user_preferred_brand, user: user, brand: cars.first.brand)
      end

      let(:car_price) { 100 }

      it 'returns perfect_match label' do
        expect(subject.cars.first.label).to eq(:perfect_match)
      end
    end

    context 'when only car brand matches' do
      before do
        create(:user_preferred_brand, user: user, brand: cars.first.brand)
      end

      let(:car_price) { 101 }

      it 'returns good_match label' do
        expect(subject.cars.first.label).to eq(:good_match)
      end
    end

    context 'when neither car brand and price range match' do
      let(:car_price) { 101 }

      it 'returns nil label' do
        expect(subject.cars.first.label).to be_nil
      end
    end
  end
end
