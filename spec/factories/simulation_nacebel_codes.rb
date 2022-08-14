# frozen_string_literal: true

# == Schema Information
#
# Table name: simulation_nacebel_codes
#
#  id              :bigint           not null, primary key
#  simulation_id   :bigint           not null
#  nacebel_code_id :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
  factory :simulation_nacebel_code do
    association :simulation, strategy: :build
    association :nacebel_code, strategy: :build
  end
end
