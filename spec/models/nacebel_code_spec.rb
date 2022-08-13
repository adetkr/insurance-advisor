# frozen_string_literal: true
require 'rails_helper'

RSpec.describe NacebelCode, type: :model do
  let(:nacebel_code) { build_stubbed :nacebel_code }

  describe 'validations' do
    it 'validates presence' do
      expect(nacebel_code).to validate_presence_of(:identifier)
    end

    describe 'identifier format validations' do
      let(:nacebel_code) { build_stubbed :nacebel_code, identifier: identifier }
      let(:identifier) { '01234' }

      context 'when identifier is valid' do
        it { expect(nacebel_code).to be_valid }
      end

      context 'when identifier is not valid' do
        let(:identifier) { '22' }

        it { expect(nacebel_code).to be_invalid }
      end
    end
  end
end
