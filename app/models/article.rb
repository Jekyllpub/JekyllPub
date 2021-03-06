class Article < ActiveRecord::Base
  has_attached_file :thumbnail,
  					:styles => { :medium => "300x300>" },
  					:default_url => "/images/:style/missing.png"

  validates_attachment_content_type :thumbnail, :content_type => /\Aimage\/.*\Z/
end
