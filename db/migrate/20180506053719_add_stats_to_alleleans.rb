class AddStatsToAlleleans < ActiveRecord::Migration[5.1]
  def change
    add_column :alleleans, :multiplier_steps, :float
    add_column :alleleans, :multiplier_calories, :float
    add_column :alleleans, :multiplier_sleep, :float
    add_column :alleleans, :multiplier_water, :float
  end
end
