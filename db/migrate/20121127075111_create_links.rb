class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url
      t.string :title
      t.string :photo
      t.integer :rate
      t.timestamps
    end
  end
end
