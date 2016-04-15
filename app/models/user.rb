class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_create :generate_authentication_token!

  validates :auth_token, uniqueness: true
  validates :name, presence: true
  validates :nickname, presence: true, uniqueness: true
  validates :birthdate, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :scores, presence: true, numericality: true


  #Generate token for authetication user
  def generate_authentication_token!
  	begin
  		self.auth_token = Devise.friendly_token
  	end while self.class.exists?(auth_token: auth_token)
  end
end
