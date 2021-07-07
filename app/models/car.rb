# frozen_string_literal: true

class Car < ApplicationRecord
  belongs_to :brand

  attr_accessor :rank_score, :label
end
