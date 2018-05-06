class AddHelixToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :helix_ids, :integer, array: true
  end
end
