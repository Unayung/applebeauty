class AddUrlIndexOnLinks < ActiveRecord::Migration
  def up
  	add_index :links, :url
  end

  def down
  	remove_index :links, :url
  end
end
