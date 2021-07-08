# frozen_string_literal: true

class BrandSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :cars
end
