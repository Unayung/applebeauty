class AddLiffIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :liff_uid, :string
    add_index :users, :liff_uid
  end
end
