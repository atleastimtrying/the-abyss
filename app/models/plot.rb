class Plot < ActiveRecord::Base
  scope :published, -> { where published: true }
  scope :unpublished, -> { where published: false }
  scope :pending, -> { unpublished.order('created_at DESC') }
end
