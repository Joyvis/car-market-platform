# frozen_string_literal: true

class Users::CarsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def index
    results = Users::ListRecommendedCars.call(
      user: user,
      brand_name: params[:query],
      price_min: params[:price_min],
      price_max: params[:price_max]
    ).recommended_cars

    render json: results, each_serializer: CarSerializer
  end

  private

  def user
    User.find(params[:user_id])
  end

  def render_not_found
    head :not_found
  end
end
