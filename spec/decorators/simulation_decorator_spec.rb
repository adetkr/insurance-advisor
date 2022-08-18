# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SimulationDecorator do
  let!(:simulation) { build_stubbed :simulation, quote: { data: { deductible: 1000, coverageCeiling: 3000 } } }

  describe '.display_deductible' do
    subject(:display_deductible) { described_class.new(simulation).display_deductible }

    it 'returns the deductible amount with title' do
      expect(display_deductible).to eq('Franchise : 1000€')
    end
  end

  describe '.display_coverage_ceiling' do
    subject(:display_coverage_ceiling) { described_class.new(simulation).display_coverage_ceiling }

    it 'returns the coverage ceiling amount with title' do
      expect(display_coverage_ceiling).to eq('Maximum de couverture : 3000€')
    end
  end
end
