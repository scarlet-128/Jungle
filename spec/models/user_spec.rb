require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it "is valid with valid attributes" do
      @user = User.create(
        first_name: "Monica",
        last_name: "Wang",
        email: "monica@email.com",
        password: "Password",
        password_confirmation: "Password"
      )
      expect(@user).to be_valid
    end
    it "is not valid without a password and password_confirmation" do
      @user = User.create(
        first_name: "Monica",
        last_name: "Wang",
        email: "monica@email.com",
        password: "Password",
        password_confirmation: "Passw"
      )
      expect(@user).to_not be_valid
    end
    it "is not valid without an unique_email" do
      User.create(
        first_name: "Monica",
        last_name: "Wang",
        email: "monica@email.com",
        password: "Password",
        password_confirmation: "Password"
      )
      @user = User.create(
        first_name: "Monica",
        last_name: "Wang",
        email: "monica@email.com",
        password: "Password",
        password_confirmation: "Password"
      )
      expect(@user).to_not be_valid
    end
    it "is not valid without a email" do
      @user = User.create(
        first_name: "Monica",
        last_name: "Wang",
        email: nil,
        password: "Password",
        password_confirmation: "Password"
      )
      expect(@user).to_not be_valid
    end
   it "is not valid without a name" do
      @user = User.create(
        first_name: nil,
        last_name: nil,
        email: "monica@email.com",
        password: "Password",
        password_confirmation: "Password"
      )
      expect(@user).to_not be_valid
    end
    it "is not valid without minimum password length" do
      @user = User.create(
        first_name: "Monica",
        last_name: "Wang",
        email: "monica@email.com",
        password: "Pass",
        password_confirmation: "Pass"
      )
      expect(@user).to_not be_valid
    end
  end
  describe '.authenticate_with_credentials' do
    it 'return an instance of user with correct email and password' do
      @user = User.create(
        first_name: "Monica",
        last_name: "Wang",
        email: "monica@email.com",
        password: "Password",
        password_confirmation: "Password"
      )
      expect(User.authenticate_with_credentials('monica@email.com', 'Password')).to eq(@user)
    end
    it 'validates emails that have spaces around them' do
      @user = User.create(
        first_name: "Monica",
        last_name: "Wang",
        email: "monica@email.com",
        password: "Password",
        password_confirmation: "Password"
      )
      expect(User.authenticate_with_credentials('  monica@email.com  ', 'Password')).to eq(@user)
    end
    it 'validates emails that have incorrect casing' do
      @user = User.create(
        first_name: "Monica",
        last_name: "Wang",
        email: "monica@email.com",
        password: "Password",
        password_confirmation: "Password"
      )
      expect(User.authenticate_with_credentials('MONICA@email.com', 'Password')).to eq(@user)
  end
end

end
