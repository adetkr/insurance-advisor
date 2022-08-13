# frozen_string_literal: true
class CreateNacebelCodes < ActiveRecord::Migration[6.1]
  def change
    create_table :nacebel_codes do |t|
      t.string :identifier, null: false
      t.string :description
      t.timestamps
    end
  end
end
