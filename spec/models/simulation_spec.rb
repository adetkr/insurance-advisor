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
require 'rails_helper'

RSpec.describe Simulation, type: :model do
  let(:simulation) { build_stubbed :simulation }
  
  describe 'relations' do
    it 'has relations' do
      expect(simulation).to belong_to(:contact)
    end
  end

  describe 'validations' do
    it 'validates presence' do
      expect(simulation).to validate_presence_of(:annual_revenue)
      expect(simulation).to validate_presence_of(:company_legal_name)
      expect(simulation).to validate_presence_of(:natural_person)
      expect(simulation).to validate_presence_of(:enterprise_number)
      expect(simulation).to validate_numericality_of(:annual_revenue).is_greater_than_or_equal_to(0)
    end

    describe 'enterprise number format validations' do
      let(:simulation) { build_stubbed :simulation, enterprise_number: enterprise_number }
      let(:enterprise_number) { '0123456789' }

      context 'when enterprise number is valid' do
        it { expect(simulation).to be_valid }
      end

      context 'when enterprise number is not valid' do
        let(:enterprise_number) { '1123456789' }

        it { expect(simulation).to be_invalid }
      end
    end
  end
end
