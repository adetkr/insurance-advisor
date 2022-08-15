# frozen_string_literal: true
# rubocop:disable all
namespace :deploy do
  desc 'Import nacebel Data from CSV'
  task import_nacebel_data: :environment do
    file = URI.open(ENV['NACEBEL_DATA_URL'])
    CSV.read(file, headers: :first_row, col_sep: ';', encoding: 'windows-1252:utf-8').each do |row|
      NacebelCode.create(identifier: row[1], description: row[4]) if row[1].present? && row[1].length == 5
    end
  end
end
