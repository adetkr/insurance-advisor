# frozen_string_literal: true
FactoryBot.define do
  factory :simulation_nacebel_code do
    association :simulation, strategy: :build
    association :nacebel_code, strategy: :build
  end
end
