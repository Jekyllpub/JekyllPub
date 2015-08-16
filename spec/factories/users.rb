FactoryGirl.define do
  factory :user do
    username Faker::Internet.user_name
    email Faker::Internet.email
		pass = Faker::Internet.password(8)
		password pass
		password_confirmation pass
    #password_digest "MyString"
  end

end
