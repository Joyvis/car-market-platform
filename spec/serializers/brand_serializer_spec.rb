# frozen_string_literal: true

require 'rails_helper'

describe BrandSerializer, type: :serializer do
  let(:brand) { create(:brand) }

  subject { described_class.new(brand).serializable_hash }

  describe 'checking attributes presence' do
    it { is_expected.to include(:id) }
    it { is_expected.to include(:name) }
  end
end
