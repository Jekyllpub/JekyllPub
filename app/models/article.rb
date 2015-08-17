class Article < ActiveRecord::Base
  has_attached_file :thumbnail,
  					:styles => { :medium => "300x300>" },
  					:path => "/:style/:id_:filename",
  					:storage => :dropbox,
  					:dropbox_credentials => Rails.root.join("config/dropbox.yml")  

  validates_attachment_content_type :thumbnail, :content_type => /\Aimage\/.*\Z/
end
