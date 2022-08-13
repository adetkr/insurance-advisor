# frozen_string_literal: true
class SimulationsController < ApplicationController
  def create
    @simulation = Simulation.new(simulation_params)

    if @simulation.save
      redirect_to simulation_path(@simulation)
    else
      render "simulation/needs/show"
    end
  end

  def show
    @simulation = Simulation.find(params[:id])
  end

  def update
    @simulation = Simulation.find(params[:id])

    if @simulation.update(simulation_params)
      redirect_to simulation_path(@simulation)
    else
      render "simulation/needs/edit"
    end
  end

  private

  def simulation_params
    params.require(:simulation).permit(:contact_id, :annual_revenue, :company_legal_name, :natural_person, :enterprise_number)
          .merge(params.require(:simulation).permit(nacebel_code_ids: []))
  end
end
