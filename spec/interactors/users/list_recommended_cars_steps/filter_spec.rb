# frozen_string_literal: true

require 'rails_helper'

describe Users::ListRecommendedCarsSteps::Filter do
  let(:brand) { create(:brand, name: 'Test Brand') }
  let(:price) { 999_999_999 }

  before do
    create(:car, model: 'Test Card', price: price, brand: brand)
  end

  describe 'filtering by brand name' do
    subject { described_class.call(brand_name: brand_name) }

    context 'when brand name matches' do
      context 'and it is a complete brand name' do
        let(:brand_name) { brand.name }

        it 'returns test brand cars' do
          expect(subject.cars.count).to eq(1)
          expect(subject.cars.first.brand.name).to eq(brand.name)
        end
      end

      context 'and it is a partial brand name' do
        let(:brand_name) { 'Test' }

        it 'returns test brand cars' do
          expect(subject.cars.count).to eq(1)
          expect(subject.cars.first.brand.name).to eq(brand.name)
        end
      end
    end

    context 'when brand name does not match' do
      let(:brand_name) { 'False Brand' }

      it 'returns an empty list' do
        expect(subject.cars.count).to be_zero
      end
    end

    context 'when brand name is not present' do
      let(:brand_name) { nil }

      it 'returns all created cars' do
        expect(subject.cars.count).to eq(Car.all.count)
      end
    end
  end

  describe 'filtering by price' do
    subject { described_class.call(price_min: price_min, price_max: price_max) }

    context 'when only price_min is present' do
      let(:price_min) { 999_999_998 }
      let(:price_max) { nil }

      it 'returns cars filtered by min price' do
        expect(subject.cars.count).to eq(1)
        expect(subject.cars.first.brand.name).to eq(brand.name)
      end
    end

    context 'when only price_max is present' do
      let(:price_min) { nil }
      let(:price_max) { 999_999_999 }

      it 'returns cars filtered by min price' do
        expect(subject.cars.count).to eq(Car.all.count)
      end
    end

    context 'when both price params are present' do
      let(:price_min) { 999_999_998 }
      let(:price_max) { 999_999_999 }

      it 'returns cars filtered by min price' do
        expect(subject.cars.count).to eq(1)
        expect(subject.cars.first.brand.name).to eq(brand.name)
      end
    end
  end
end
