# -*- encoding : utf-8 -*-
class AddIndexToLinkTitle < ActiveRecord::Migration
  def change
    add_index :links, :title
  end
end
