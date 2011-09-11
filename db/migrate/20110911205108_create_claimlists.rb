class CreateClaimlists < ActiveRecord::Migration
  def change
    create_table :claimlists do |t|
      t.references :user

      t.timestamps
    end
    
    add_index :claimlists, :user_id
  end
end
