class Plot < ActiveRecord::Base
  attr_accessible :description, :title, :x, :y, :state
  belongs_to :user
end
