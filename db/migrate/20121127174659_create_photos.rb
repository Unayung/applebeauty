# -*- encoding : utf-8 -*-
class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :file
      t.integer :link_id
      t.string :file_width
      t.string :file_height
      t.string :file_image_size
      t.string :file_content_type

      t.string :file_tiny_width
      t.string :file_tiny_height
      t.string :file_tiny_image_size
      t.string :file_tiny_content_type

      t.timestamps
    end
  end
end
