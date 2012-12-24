class User < ActiveRecord::Base
  attr_accessible :email, :password, :user_name, :x, :y
  validates :email, :length => { :maximum => 140 }
  validates :password, :length => { :maximum => 140 }
  validates :user_name, :length => { :maximum => 140 }
  validates :x, :length => { :maximum => 140 }
  validates :y, :length => { :maximum => 140 }
  has_many :plots
end
