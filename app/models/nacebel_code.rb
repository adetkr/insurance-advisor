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
class NacebelCode < ApplicationRecord
  COVERS_KEYS = ['after_delivery', 'public_liability', 'legal_expenses',
                 'professional_indemnity', 'entrusted_objects'
  ].freeze
  DEDUCTIBLE_FORMULA_OPTIONS = [ 'small', MEDIUM_DEDUCTIBLE_FORMULA_OPTION = 'medium', 'large'].freeze
  COVERAGE_CEILING_FORMULA_OPTIONS = [SMALL_COVERAGE_CEILING_FORMULA_OPTION = 'small', 'large'].freeze

  has_many :simulation_nacebel_codes, dependent: :destroy
  validates :identifier, presence: true
  validates :identifier, format: { with: /\d{5}/ }

  store_accessor :recommendations, :covers, :deductible_formula, :coverage_ceiling_formula

  def self.with_recommendations
    where.not(recommendations: [nil, {}])
  end

  validate :covers_recommendation_correctness
  validate :deductible_formula_recommendation_correctness
  validate :coverage_ceiling_formula_recommendation_correctness

  private

  def covers_recommendation_correctness
    return if recommendations.blank? || covers.blank?

    errors.add(:recommendations, :invalid_covers) unless
      covers.is_a?(Array) && (covers - COVERS_KEYS).empty?
  end

  def deductible_formula_recommendation_correctness
    return if recommendations.blank? || deductible_formula.blank?

    errors.add(:recommendations, :invalid_deductible_formula) unless
      DEDUCTIBLE_FORMULA_OPTIONS.include?(deductible_formula)
  end

  def coverage_ceiling_formula_recommendation_correctness
    return if recommendations.blank? || coverage_ceiling_formula.blank?

    errors.add(:recommendations, :invalid_coverage_celing_formula) unless
      COVERAGE_CEILING_FORMULA_OPTIONS.include?(coverage_ceiling_formula)
  end
end
