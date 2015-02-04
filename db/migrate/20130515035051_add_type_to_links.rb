class AddTypeToLinks < ActiveRecord::Migration
  def change
    add_column :links, :link_type, :string, :default => "daily"
    add_index :links, :link_type
  end
end
