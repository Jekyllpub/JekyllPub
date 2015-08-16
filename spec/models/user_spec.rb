require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
		expect(FactoryGirl.create(:user)).to be_valid
	end

	it "is invalid withot username" do
		expect(FactoryGirl.build(:user,username: nil)).to be_invalid
	end

	it "is invalid without email" do
		expect(FactoryGirl.build(:user,email: nil)).to be_invalid
	end

	it "is invalid with short password " do
		pass = Faker::Internet.password(4)
		expect(FactoryGirl.build(:user,password: pass,password_confirmation: pass)).to be_invalid
	end

	it "is valid with long password " do
		pass = Faker::Internet.password(10)
		expect(FactoryGirl.build(:user,password: pass,password_confirmation: pass)).to be_valid
	end
end
