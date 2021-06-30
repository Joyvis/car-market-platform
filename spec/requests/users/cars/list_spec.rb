# frozen_string_literal: true

require 'rails_helper'

describe 'listing recommended cars for users' do
  before { get "/users/#{user_id}/cars" }

  context 'with a valid user_id' do
    let(:response_json) { JSON.parse(response.body, symbolize_names: true) }
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
    let(:user_id) { 212121 }

    it 'returns a http status :not_found' do
      expect(response).to have_http_status(:not_found)
    end
  end
end
