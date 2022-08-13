# frozen_string_literal: true
# == Schema Information
#
# Table name: contacts
#
#  id           :bigint           not null, primary key
#  first_name   :string           not null
#  last_name    :string           not null
#  email        :string           not null
#  address      :string           not null
#  phone_number :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
FactoryBot.define do
  factory :contact do
    sequence(:first_name) { |n| "prenom_#{n}" }
    sequence(:last_name) { |n| "nom_#{n}" }
    sequence(:email) { |n| "email#{n}@gmail.com" }
    sequence(:phone_number) { |n| "061#{n.to_s.rjust(7, '0')}" }
    sequence(:address) { |n| "prenom_#{n}" }
  end
end
