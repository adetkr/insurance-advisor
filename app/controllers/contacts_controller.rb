# frozen_string_literal: true
class ContactsController < ApplicationController
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to simulation_contact_needs_path(@contact)
    else
      render "simulation/profiles/show"
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :address, :phone_number)
  end
end
