class CreateWantlists < ActiveRecord::Migration
  def change
    create_table :wantlists do |t|
      t.references :user

      t.timestamps
    end
    
    add_index :wantlists, :user_id
  end
end
