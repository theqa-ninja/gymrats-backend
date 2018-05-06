class AddHelixToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :user, :helix_ids, :integer, array: true
  end
end
