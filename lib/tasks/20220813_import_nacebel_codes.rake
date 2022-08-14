# frozen_string_literal: true
# rubocop:disable all
namespace :deploy do
  desc 'Import nacebel Data from CSV'
  task import_nacebel_data: :environment do
    #file = URI.open(ENV['NACEBEL_DATA_URL'])
    file = URI.open('NACEBEL_2008.csv')
    csv = CSV.new(file.read, headers: :first_row, col_sep: ';', encoding: 'ISO-8859-1', liberal_parsing: true)
    csv.each do |row|
      #puts "#{row[1]} - #{row[6]}" if row[1].present? && row[1].length == 5
      NacebelCode.create(identifier: row[1], description: row[6]) if row[1].present? && row[1].length == 5
    end
  end
end
