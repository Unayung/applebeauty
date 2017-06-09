class AddSlugToLink < ActiveRecord::Migration
  def change
    add_column :links, :slug, :string, :uniqueness => true
  end
end
