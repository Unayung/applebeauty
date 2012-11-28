class RemovePhotoFromLink < ActiveRecord::Migration
  def up
    remove_column :links, :photo
  end

  def down
    add_column :links, :photo, :string
  end
end
