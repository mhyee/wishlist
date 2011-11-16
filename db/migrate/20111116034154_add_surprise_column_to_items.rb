class AddSurpriseColumnToItems < ActiveRecord::Migration
  def change
    add_column :items, :surprise, :boolean, :default => false
  end
end
