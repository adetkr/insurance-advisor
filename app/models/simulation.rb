# frozen_string_literal: true
# == Schema Information
#
# Table name: simulations
#
#  id                 :bigint           not null, primary key
#  contact_id         :bigint           not null
#  annual_revenue     :integer
#  enterprise_number  :string
#  company_legal_name :string
#  natural_person     :boolean          default(FALSE)
#  quote              :jsonb
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Simulation < ApplicationRecord
  belongs_to :contact
  has_many :simulation_nacebel_codes, dependent: :destroy
  has_many :nacebel_codes, through: :simulation_nacebel_codes

  validates :annual_revenue, :company_legal_name,
            :enterprise_number, presence: true
  validates :annual_revenue, numericality: { greater_than_or_equal_to: 0 }
  validates :enterprise_number, format: { with: /0\d{9}/ }

  store_accessor :quote, :data, :message, :success

  attr_accessor :coverage_ceiling_formula, :deductible_formula

  accepts_nested_attributes_for :nacebel_codes, allow_destroy: true
  accepts_nested_attributes_for :simulation_nacebel_codes, allow_destroy: true
end
