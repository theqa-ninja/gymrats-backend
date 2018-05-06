class CreateStables < ActiveRecord::Migration[5.1]
  def change
    create_table :stables do |t|
      t.integer :user_id, null: false
      t.integer :allelean_id, null: false
      t.boolean :is_active, default: false
      t.datetime :aquired_date
      t.integer :exp, default: 0
      t.integer :level, default: 1

      t.timestamps
    end
  end
end
