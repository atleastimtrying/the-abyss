class AddPublishedToPlots < ActiveRecord::Migration
  def change
    add_column :plots, :published, :boolean
  end
end
