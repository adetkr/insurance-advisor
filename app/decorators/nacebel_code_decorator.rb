# frozen_string_literal: true
class NacebelCodeDecorator < SimpleDelegator
  def display_deductible_formula
    "#{ I18n.t('simulations.show.deductible_formula_recommendation') } : #{ deductible_formula }"
  end

  def display_coverage_ceiling_formula
    "#{ I18n.t('simulations.show.coverage_ceiling_formula_recommendation') } : #{ coverage_ceiling_formula }"
  end

  def display_activity
    "#{ I18n.t('simulations.show.about_activity') } #{ identifier }"
  end
end
