# frozen_string_literal: true
require 'rails_helper'

RSpec.describe PagesController, type: :request do
  describe 'show' do
    before do
      get "/"
    end

    it 'is successful' do
      expect(response).to be_successful
    end
  end
end
