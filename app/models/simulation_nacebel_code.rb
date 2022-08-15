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
class SimulationNacebelCode < ApplicationRecord
  belongs_to :simulation
  belongs_to :nacebel_code
end
