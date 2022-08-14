class AddRecommendationToNacebelCode < ActiveRecord::Migration[6.1]
  def change
    add_column :nacebel_codes, :recommendations, :jsonb
  end
end
