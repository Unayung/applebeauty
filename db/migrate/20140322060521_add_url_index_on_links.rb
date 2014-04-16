class AddUrlIndexOnLinks < ActiveRecord::Migration
  def up
  	add_index :links, :url, :unique => true
  end

  def down
  	remove_index :links, :url
  end
end
