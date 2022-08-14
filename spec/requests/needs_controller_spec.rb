# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Simulation::ProfilesController, type: :request do
  let!(:contact) { create :contact }
  let!(:simulation) { create :simulation }

  describe 'show' do
    before do
      get "/simulation/contacts/#{contact.id}/votre-besoin"
    end

    it 'is successful' do
      expect(response).to be_successful
    end
  end

  describe 'edit' do
    before do
      get "/simulation/contacts/#{contact.id}/votre-besoin/edit", params: { simulation_id: simulation.id }
    end

    it 'is successful' do
      expect(response).to be_successful
    end
  end
end
