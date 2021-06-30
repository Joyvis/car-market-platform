# frozen_string_literal: true

require 'rails_helper'

describe Car do
  describe 'associations' do
    it { is_expected.to belong_to(:brand) }
  end
end
