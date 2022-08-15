# frozen_string_literal: true
class QuoteService
  class QuoteError < StandardError; end

  BASE_URL = ENV['QUOTE_URL']
  HEADERS = {
    'X-Api-Key' => ENV['QUOTE_SERVICE_API_KEY'],
    'Content-Type' => 'application/json'
  }.freeze

  def initialize(simulation)
    @simulation = simulation
  end

  def post
    parse_response(HTTParty.post(BASE_URL, { headers: HEADERS, body: data.to_json }))
  end

  private

  attr_reader :simulation

  delegate :annual_revenue, :company_legal_name, :deductible_formula, :coverage_ceiling_formula,
           :enterprise_number, :natural_person, :nacebel_codes, to: :simulation

  def data
    {
      annualRevenue: annual_revenue,
      enterpriseNumber: enterprise_number,
      legalName: company_legal_name,
      naturalPerson: natural_person,
      nacebelCodes: nacebel_codes.map(&:identifier),
      deductibleFormula: deductible_formula.presence || 'medium',
      coverageCeilingFormula: coverage_ceiling_formula.presence || 'small'
    }
  end

  def parse_response(response)
    parsed_response = JSON.parse(response.body)
    return parsed_response if parsed_response.is_a?(Hash)

    error(parsed_response)
  rescue JSON::ParserError
    error(response.body)
  end

  def error(message)
    raise QuoteError, message
  end
end
