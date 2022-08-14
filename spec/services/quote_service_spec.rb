# frozen_string_literal: true

require 'rails_helper'

RSpec.describe QuoteService do
  let(:headers) do
    {
      'X-Api-Key' => 'good_api_key',
      'Content-Type' => 'application/json'
    }
  end

  before do
    stub_const(
      'QuoteService::BASE_URL',
      'https://api.quote.com'
    )

    stub_const(
      'QuoteService::HEADERS',
      headers
    )
  end

  describe '.post' do
    let!(:nacebel_code) { create :nacebel_code }
    let!(:simulation) do
      create :simulation, annual_revenue: 123, company_legal_name: 'awesome_name',
                          deductible_formula: 'small', coverage_ceiling_formula: 'large',
                          enterprise_number: '0123456789', natural_person: true,
                          nacebel_codes: [nacebel_code]
    end
    let(:response) { '{ "id": "1" }' }
    let(:expected_body) {
      {
        annualRevenue: 123,
        enterpriseNumber: '0123456789',
        legalName: 'awesome_name',
        naturalPerson: true,
        nacebelCodes: [nacebel_code.identifier],
        deductibleFormula: 'small',
        coverageCeilingFormula: 'large'
      }
    }
    subject(:post) { described_class.new(simulation).post }

    before do
      allow(HTTParty).to receive(:post).and_return(double(body: response))
    end

    it 'makes the correct HTTP request and returns the parsed response' do
      expect(post).to eq({ 'id' => '1' })
      expect(HTTParty).to have_received(:post).with(
        'https://api.quote.com',
        { headers: headers, body: expected_body.to_json }
      )
    end

    context 'when the response is not valid json' do
      let(:response) { '{ "id" "1" }' }

      it 'raises an exception' do
        expect { post }.to raise_exception(
          described_class::QuoteError,
          '{ "id" "1" }'
        )
      end
    end

    context 'when the response is an error string' do
      let(:response) { '"This is an error"' }

      it 'raises an exception' do
        expect { post }.to raise_exception(
          described_class::QuoteError,
          'This is an error'
        )
      end
    end
  end
end
