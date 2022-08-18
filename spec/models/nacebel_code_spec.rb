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

    describe 'recommendations correctness' do
      let(:nacebel_code) { build_stubbed :nacebel_code, recommendations: recommendations }

      before { nacebel_code.validate(:recommendations) }

      context 'when recommendations are valid' do
        let(:recommendations) do
          {
            covers: %w[after_delivery],
            deductible_formula: 'small',
            coverage_ceiling_formula: 'large'
          }
        end

        it { expect(nacebel_code.errors[:recommendations]).to be_empty }
      end

      context 'when the covers recommendation are wrong' do
        let(:recommendations) do
          {
            covers: %w[after_delivery random_guarantee],
            deductible_formula: 'small',
            coverage_ceiling_formula: 'large'
          }
        end

        it { expect(nacebel_code.errors[:recommendations].first).not_to be_empty }
      end

      context 'when the deductible recommendation is wrong' do
        let(:recommendations) do
          {
            covers: %w[after_delivery],
            deductible_formula: 'tiny',
            coverage_ceiling_formula: 'large'
          }
        end

        it { expect(nacebel_code.errors[:recommendations].first).not_to be_empty }
      end

      context 'when the coverage ceiling recommendation is wrong' do
        let(:recommendations) do
          {
            covers: %w[after_delivery],
            deductible_formula: 'small',
            coverage_ceiling_formula: 'big'
          }
        end

        it { expect(nacebel_code.errors[:recommendations].first).not_to be_empty }
      end
    end
  end

  describe 'scopes' do
    describe '.with_recommendations' do
      subject { described_class.with_recommendations }

      let!(:without_recommendation) { create :nacebel_code }
      let!(:with_covers_recommendation) do
        create :nacebel_code, recommendations: { covers: %w[after_delivery public_liability] }
      end
      let!(:with_formula_recommendation) do
        create :nacebel_code, recommendations: { deductible_formula: 'small' }
      end

      it { is_expected.to contain_exactly with_covers_recommendation, with_formula_recommendation }
    end
  end
end
