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
  has_many :simulation_nacebel_codes, dependent: :destroy
  validates :identifier, presence: true
  validates :identifier, format: { with: /\d{5}/,
                                          message: 'Nacebel number always have 5 digits'
                                        }

  store_accessor :recommendations, :covers, :deductible_formula, :coverage_ceiling_formula
end
