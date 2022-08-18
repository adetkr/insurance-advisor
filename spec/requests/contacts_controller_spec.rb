# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContactsController, type: :request do
  describe 'create' do
    let(:params) { { 'contact' => { 'first_name': 'sylvanus',
                                    'last_name': 'olympio',
                                    'email': 'test@gmail.com',
                                    'address': 'best address',
                                    'phone_number': '0732455678'
                                  } 
                    }
                  }

    context 'when params are valid' do
      it 'is successful' do
        expect { post '/contacts', params: params }.to change(Contact, :count).by(1)
      end
    end

    context 'when params are not valid' do
      let(:params) { { 'contact' => { 'first_name': nil } } }

      it 'does not create shop' do
        expect { post '/contacts', params: params }.to change(Contact, :count).by(0)
      end
    end
  end
end
