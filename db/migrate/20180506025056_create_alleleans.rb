class CreateAlleleans < ActiveRecord::Migration[5.1]
  def change
    create_table :alleleans do |t|
      t.text :name, null: false
      t.text :photo, null: false
      t.integer :evolve_id

      t.timestamps
    end
  end
end
