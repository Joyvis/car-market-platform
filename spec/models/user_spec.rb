# frozen_string_literal: true

require 'rails_helper'

describe User do
  describe 'associations' do
    it do
      is_expected
        .to have_many(:preferred_brands)
        .through(:user_preferred_brands)
        .source(:brand)
    end
  end
end
