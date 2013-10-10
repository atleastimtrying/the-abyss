class Plot < ActiveRecord::Base
  scope :published, -> { where published: true }
  scope :unpublished, -> { where published: false }
  scope :pending, -> { unpublished.order('created_at DESC') }
  def walls
    response = []
    response.push :north if north_wall
    response.push :south if south_wall
    response.push :east if east_wall
    response.push :west if west_wall
    response
  end
end
