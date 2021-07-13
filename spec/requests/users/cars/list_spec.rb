# frozen_string_literal: true

require 'rails_helper'

describe 'listing recommended cars for users' do
  before do
    allow(BravadoRecommendationExternalService)
      .to receive(:get_recommended_cars) { [] }
    create_list(:car, 50)

    get "/users/#{user_id}/cars"
  end

  let(:response_json) { JSON.parse(response.body, symbolize_names: true) }

  context 'with a valid user_id' do
    let(:recommended_car_keys) { response_json.first.keys }
    let(:car_brand_keys) { response_json.first[:brand].keys }
    let(:user_id) { create(:user).id }

    it 'returns a http status :ok' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns an array of recommended cars' do
      expect(response_json).to be_a Array
      expect(recommended_car_keys).to include(:id)
      expect(recommended_car_keys).to include(:model)
      expect(recommended_car_keys).to include(:brand)
      expect(recommended_car_keys).to include(:price)
      expect(recommended_car_keys).to include(:rank_score)
      expect(recommended_car_keys).to include(:label)
    end

    it 'returns a brand relationship' do
      expect(car_brand_keys).to include(:id)
      expect(car_brand_keys).to include(:name)
    end
  end

  context 'with a invalid user_id' do
    let(:user_id) { 212_121 }

    it 'returns a http status :not_found' do
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when pagination is necessary' do
    let(:user_id) { create(:user).id }

    it 'returns a paginated response' do
      expect(response_json.count).to eq(20)
    end
  end
end
