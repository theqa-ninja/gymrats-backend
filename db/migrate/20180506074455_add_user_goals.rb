class AddUserGoals < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :daily_steps, :integer
    add_column :users, :daily_calorie_burn, :integer
    add_column :users, :daily_distance, :integer
    add_column :users, :daily_floors, :integer
    add_column :users, :daily_water_in_cups, :integer
    add_column :users, :daily_sleep_in_mins, :integer
    add_column :users, :daily_bedtime, :time
    add_column :users, :daily_wakeuptime, :time
  end
end
