# frozen_string_literal: true
class Funnel::ProfilesController < ApplicationController
  def show
    @contact = Contact.new
  end
end
