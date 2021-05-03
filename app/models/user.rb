class User < ActiveRecord::Base

  has_secure_password 
  validates :email, uniqueness: { case_sensitive: false }, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: { minimum: 5 }, presence: true
  validates :password_confirmation, presence: true


  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.downcase.strip)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end
end
