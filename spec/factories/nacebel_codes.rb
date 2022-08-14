# frozen_string_literal: true

# == Schema Information
#
# Table name: nacebel_codes
#
#  id              :bigint           not null, primary key
#  identifier      :string           not null
#  description     :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  recommendations :jsonb
#
FactoryBot.define do
  factory :nacebel_code do
    sequence(:identifier) { '11111' }
  end
end
