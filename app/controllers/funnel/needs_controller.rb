# frozen_string_literal: true
class Funnel::NeedsController < ApplicationController
  def show
    @simulation = Simulation.new(contact: Contact.find(params[:contact_id]))
  end

  def edit
    @simulation = Simulation.find(params[:simulation_id])
  end
end
