# frozen_string_literal: true
class AddReferenceToNacebelCodesInSimulations < ActiveRecord::Migration[6.1]
  def change
    remove_column :simulations, :nacebel_codes
  end
end
