class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :link_id
      t.string :photo
      t.integer :photo_width
      t.integer :photo_height
      t.timestamps
    end

    add_column :images, :photo_size, :integer
    add_column :images, :photo_content_type, :string

    add_column :images, :photo_tiny_height, :integer
    add_column :images, :photo_tiny_width, :integer
    add_column :images, :photo_tiny_size, :integer
    add_column :images, :photo_tiny_content_type, :string

  end
end
