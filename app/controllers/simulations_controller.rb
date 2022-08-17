# frozen_string_literal: true
class SimulationsController < ApplicationController
  before_action :set_simulation, only: %i[show update]
  after_action :update_simulation_quote, only: %i[create update], if: :current_simulation_is_valid?

  def create
    @simulation = Simulation.new(simulation_params)

    if @simulation.save
      redirect_to simulation_path(@simulation)
    else
      render "funnel/needs/show"
    end
  end

  def show
    @filtered_nacebel_codes = @simulation.nacebel_codes.with_recommendations
  end

  def update
    if @simulation.update(simulation_params)
      redirect_to simulation_path(@simulation)
    else
      render "funnel/needs/edit"
    end
  end

  private

  def simulation_params
    params.require(:simulation).permit(:contact_id, :annual_revenue, :company_legal_name,
                                       :coverage_ceiling_formula, :deductible_formula,
                                       :natural_person, :enterprise_number, nacebel_code_ids: []
                                      )
  end

  def set_simulation
    @simulation = Simulation.find(params[:id])
  end

  def update_simulation_quote
    @simulation.update(quote: QuoteService.new(@simulation).post)
  end

  def current_simulation_is_valid?
    @simulation.valid?
  end
end
