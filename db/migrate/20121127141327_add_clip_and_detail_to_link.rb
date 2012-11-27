class AddClipAndDetailToLink < ActiveRecord::Migration
  def change
    add_column :links, :clip, :string
    add_column :links, :detail, :text
    add_index :links, :url,  :unique => true
  end
end
