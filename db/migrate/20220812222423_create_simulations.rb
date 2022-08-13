# frozen_string_literal: true
class CreateSimulations < ActiveRecord::Migration[6.1]
  def change
    create_table :simulations do |t|
      t.references :contact, null: false, foreign_key: true
      t.integer :annual_revenue
      t.string :enterprise_number
      t.string :company_legal_name
      t.boolean :natural_person, default: false
      t.text :nacebel_codes, array: true, default: []
      t.jsonb :quote, default: {}

      t.timestamps
    end
  end
end
