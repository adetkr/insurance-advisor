# frozen_string_literal: true
class Simulation::ProfilesController < ApplicationController
  def show
    @contact = Contact.new
  end
end
