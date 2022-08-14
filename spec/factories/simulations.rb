# frozen_string_literal: true
# == Schema Information
#
# Table name: simulations
#
#  id                 :bigint           not null, primary key
#  contact_id         :bigint           not null
#  annual_revenue     :integer
#  enterprise_number  :string
#  company_legal_name :string
#  natural_person     :boolean          default(FALSE)
#  quote              :jsonb
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
FactoryBot.define do
  factory :simulation do
    association :contact, strategy: :build
    sequence(:annual_revenue) { |n| n }
    sequence(:enterprise_number) { '0123456789' }
    sequence(:company_legal_name) { |n| 'company_name_#{n}' }
    natural_person { true }
  end
end
