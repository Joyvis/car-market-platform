# frozen_string_literal: true

class Users::CarsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def index
    render json: Users::ListRecommendedCars.call(user: user)
  end

  private

  def user
    User.find(params[:user_id])
  end

  def render_not_found
    head :not_found
  end
end
