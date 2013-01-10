class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :email, :password, :user_name, :x, :y, :state
  validates :email, :length => { :maximum => 140 }
  validates :password, :length => { :maximum => 140 }
  validates :user_name, :length => { :maximum => 140 }
  validates :x, :length => { :maximum => 140 }
  validates :y, :length => { :maximum => 140 }
  has_many :plots
end
