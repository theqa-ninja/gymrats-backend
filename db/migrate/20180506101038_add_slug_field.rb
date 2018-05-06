class AddSlugField < ActiveRecord::Migration[5.1]
  def change
    add_column :alleleans, :slug, :text
  end
end
