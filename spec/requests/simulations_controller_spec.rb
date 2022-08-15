# frozen_string_literal: true
require 'rails_helper'

RSpec.describe SimulationsController, type: :request do
  let!(:nacebel_code) { create :nacebel_code }

  describe 'show' do
    let!(:simulation) { create :simulation }
    before do
      get "/simulations/#{simulation.id}"
    end

    it 'is successful' do
      expect(response).to be_successful
    end
  end

  describe 'create' do
    let!(:contact) { create :contact }
    let(:params) {
      {
        'simulation' => { 'annual_revenue': 999, 'company_legal_name': 'name',
                          'natural_person': true, 'enterprise_number': '0123456789',
                          'nacebel_code_ids': [nacebel_code.id], contact_id: contact.id
                        }
      } 
    }
    let(:quote_service) { instance_double(QuoteService) }
    let(:quote_response) { { 'awesome' => 'response' } }

    before do
      allow(QuoteService).to receive(:new).and_return(quote_service)
      allow(quote_service).to receive(:post).and_return(quote_response)
    end

    context 'when params are valid' do
      before do
        post '/simulations', params: params
      end

      it 'creates simulation' do
        expect(response).to redirect_to "/simulations/#{Simulation.last.id}"
        expect(Simulation.count).to eq 1
        expect(QuoteService).to have_received(:new).with(Simulation.last)
        expect(quote_service).to have_received(:post)
        expect(Simulation.last.quote).to eq(quote_response)
      end
    end

    context 'when params are not valid' do
      let(:params) {
        {
          'simulation' => { 'annual_revenue': 999, 'company_legal_name': 'name',
                            'natural_person': true, 'enterprise_number': '6789',
                            'nacebel_code_ids': [nacebel_code.id], contact_id: contact.id
                          }
        } 
      }

      it 'does not create simulation' do
        expect { post '/simulations', params: params }.to change(Simulation, :count).by(0)
      end
    end
  end

  describe 'update' do
    let(:params) {
      {
        'simulation' => { 'annual_revenue': 999, 'company_legal_name': 'new_name',
                          'natural_person': true, 'enterprise_number': '0123456789',
                          'nacebel_code_ids': [nacebel_code.id], contact_id: simulation.contact.id
                        }
      } 
    }
    let(:quote_service) { instance_double(QuoteService) }
    let(:quote_response) { { 'awesome' => 'update response' } }
    let!(:simulation) { create :simulation, company_legal_name: 'old_name' }

    before do
      allow(QuoteService).to receive(:new).and_return(quote_service)
      allow(quote_service).to receive(:post).and_return(quote_response)
      put "/simulations/#{simulation.id}", params: params
    end

    context 'when params are valid' do
      it 'updates simulation' do
        expect(response).to redirect_to "/simulations/#{simulation.id}"
        expect(QuoteService).to have_received(:new).with(simulation)
        expect(quote_service).to have_received(:post)
        expect(simulation.reload.quote).to eq(quote_response)
        expect(simulation.reload.company_legal_name).to eq('new_name')
      end
    end

    context 'when params are not valid' do
      let(:params) {
        {
          'simulation' => { 'annual_revenue': 999, 'company_legal_name': 'new_name',
                            'natural_person': true, 'enterprise_number': '6789',
                            'nacebel_code_ids': [nacebel_code.id]
                          }
        }
      }

      it 'does not update simulation' do
        expect(simulation.company_legal_name).to eq('old_name')
      end
    end
  end
end
