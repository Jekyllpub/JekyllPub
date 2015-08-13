class AddColumnsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :title, :string
    add_column :articles, :category, :string
    add_column :articles, :layout, :string
    add_column :articles, :video, :string
    add_column :articles, :excerpt, :text
    add_column :articles, :published, :boolean
    add_column :articles, :content, :text
  end
end
