class Plot < ActiveRecord::Base
  attr_accessible :description, :title, :x, :y
  belongs_to :user
end
