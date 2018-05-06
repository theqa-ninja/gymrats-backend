class CreateHelixInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :helix_infos do |t|
      t.text :gene
      t.text :variant
      t.text :a1
      t.text :a2
      t.text :trait
      t.text :insight
      t.text :recommend
      t.text :impact
      t.text :frequency
      t.text :references

      t.timestamps
    end
  end
end
