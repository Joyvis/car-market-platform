# frozen_string_literal: true

require 'rails_helper'

describe CarSerializer, type: :serializer do
  let(:car) { create(:car) }

  subject { described_class.new(car).serializable_hash }

  describe 'checking attributes presence' do
    it { is_expected.to include(:id) }
    it { is_expected.to include(:brand) }
    it { is_expected.to include(:price) }
    it { is_expected.to include(:rank_score) }
    it { is_expected.to include(:model) }
    it { is_expected.to include(:label) }
  end
end
