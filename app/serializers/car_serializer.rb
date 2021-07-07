# frozen_string_literal: true

class CarSerializer < ActiveModel::Serializer
  attributes :id, :brand, :price, :rank_score, :model, :label

  belongs_to :brand
end
