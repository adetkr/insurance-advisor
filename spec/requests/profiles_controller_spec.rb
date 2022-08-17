# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Funnel::ProfilesController, type: :request do
  describe 'show' do
    before do
      get "/funnel/vos-informations"
    end

    it 'is successful' do
      expect(response).to be_successful
    end
  end
end
