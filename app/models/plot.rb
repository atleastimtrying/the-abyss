class Plot < ActiveRecord::Base
  scope :published, -> { where published: true }
end
