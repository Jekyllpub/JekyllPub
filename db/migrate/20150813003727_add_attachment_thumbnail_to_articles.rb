class AddAttachmentThumbnailToArticles < ActiveRecord::Migration
  def self.up
    change_table :articles do |t|
      t.attachment :thumbnail
    end
  end

  def self.down
    remove_attachment :articles, :thumbnail
  end
end
