# frozen_string_literal: true

require 'rails_helper'

describe Brand do
  describe 'associations' do
    it { is_expected.to have_many(:cars) }
  end
end
