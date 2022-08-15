# frozen_string_literal: true

# == Schema Information
#
# Table name: nacebel_codes
#
#  id              :bigint           not null, primary key
#  identifier      :string           not null
#  description     :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  recommendations :jsonb
#
require 'rails_helper'

RSpec.describe NacebelCode, type: :model do
  let(:nacebel_code) { build_stubbed :nacebel_code }

  describe 'validations' do
    it 'validates presence' do
      expect(nacebel_code).to validate_presence_of(:identifier)
    end

    describe 'identifier format validations' do
      let(:nacebel_code) { build_stubbed :nacebel_code, identifier: identifier }
      let(:identifier) { '01234' }

      context 'when identifier is valid' do
        it { expect(nacebel_code).to be_valid }
      end

      context 'when identifier is not valid' do
        let(:identifier) { '22' }

        it { expect(nacebel_code).to be_invalid }
      end
    end
  end

  describe 'scopes' do
    describe '.with_recommendations' do
      subject { described_class.with_recommendations }

      let!(:without_recommendation) { create :nacebel_code }
      let!(:with_covers_recommendation) do
        create :nacebel_code, recommendations: { covers: ['afterDelivery', 'publicLiability'] }
      end
      let!(:with_formula_recommendation) do
        create :nacebel_code, recommendations: { deductible_formula: 'small' }
      end

      it { is_expected.to contain_exactly with_covers_recommendation, with_formula_recommendation }
    end
  end
end
