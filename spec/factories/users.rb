# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'test@test.io' }
    preferred_price_range { 10_000..15_000 }
  end
end
