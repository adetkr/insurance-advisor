# frozen_string_literal: true
class SimulationDecorator < SimpleDelegator
  def display_deductible
    "#{ I18n.t('simulations.show.deductible_formula') } : #{ data["deductible"] }"
  end

  def display_coverage_ceiling
    "#{ I18n.t('simulations.show.coverage_ceiling_formula') } : #{ data["coverageCeiling"] }"
  end
end
