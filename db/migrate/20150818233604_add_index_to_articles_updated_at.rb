class AddIndexToArticlesUpdatedAt < ActiveRecord::Migration
  def change
  	add_index :articles, :updated_at 
  end
end
