class RemoveWantlistAndClaimlistTables < ActiveRecord::Migration
  def up
    drop_table :wantlists
    drop_table :claimlists
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
