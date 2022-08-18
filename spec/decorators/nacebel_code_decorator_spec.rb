# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NacebelCodeDecorator do
  let!(:nacebel_code) do
    build_stubbed :nacebel_code, recommendations: { deductible_formula: 'small', coverage_ceiling_formula: 'small' }
  end

  describe '.display_deductible_formula' do
    subject(:display_deductible_formula) { described_class.new(nacebel_code).display_deductible_formula }

    it 'returns the deductible recommended formula with title' do
      expect(display_deductible_formula).to eq('Recommandation de formule de franchise : small')
    end
  end

  describe '.display_coverage_ceiling_formula' do
    subject(:display_coverage_ceiling_formula) { described_class.new(nacebel_code).display_coverage_ceiling_formula }

    it 'returns the coverage ceiling recommended formula with title' do
      expect(display_coverage_ceiling_formula).to eq('Recommandation de formule de maximum de couverture : small')
    end
  end

  describe '.display_activity' do
    subject(:display_activity) { described_class.new(nacebel_code).display_activity }

    it 'returns the activity with title' do
      expect(display_activity).to eq("Concernant l'activité #{nacebel_code.identifier}")
    end
  end
end
