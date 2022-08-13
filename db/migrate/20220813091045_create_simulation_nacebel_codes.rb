# frozen_string_literal: true
class CreateSimulationNacebelCodes < ActiveRecord::Migration[6.1]
  def change
    create_table :simulation_nacebel_codes do |t|
      t.references :simulation, null: false
      t.references :nacebel_code, null: false
      t.timestamps
    end
  end
end
