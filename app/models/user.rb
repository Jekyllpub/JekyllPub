class User < ActiveRecord::Base
	has_secure_password

	validates :username, presence: true
	validates :email, presence: true

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	before_save { email.downcase! } #self.email = email.downcase }

	validates :username, presence: true, length:  { minimum: 3 }
	validates :email, presence: true,
						length: { maximum: 255 },
						format: { with: VALID_EMAIL_REGEX},
						uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 8 }

end
