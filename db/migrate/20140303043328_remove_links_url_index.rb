class RemoveLinksUrlIndex < ActiveRecord::Migration
  def change
    remove_index :links, :url
  end
end
