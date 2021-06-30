# frozen_string_literal: true

require 'rails_helper'

describe UserPreferredBrand do
  describe 'associations' do
    it { is_expected.to belong_to(:brand) }
    it { is_expected.to belong_to(:user) }
  end
end
