class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :title
      t.text :description
      t.references :wantlist
      t.references :claimlist

      t.timestamps
    end
    
    add_index :items, :wantlist_id
    add_index :items, :claimlist_id
  end
end
