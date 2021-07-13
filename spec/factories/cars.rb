# frozen_string_literal: true

FactoryBot.define do
  factory :car do
    model { 'Derby' }
    price { 37_230 }
    label { nil }
    rank_score { nil }

    brand
  end
end
