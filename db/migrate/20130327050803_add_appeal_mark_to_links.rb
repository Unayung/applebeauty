class AddAppealMarkToLinks < ActiveRecord::Migration
  def change
    add_column :links, :appeal, :boolean, :default => false
  end
end
