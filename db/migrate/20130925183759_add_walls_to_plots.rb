class AddWallsToPlots < ActiveRecord::Migration
  def change
    add_column :plots, :north_wall, :boolean
    add_column :plots, :south_wall, :boolean
    add_column :plots, :east_wall, :boolean
    add_column :plots, :west_wall, :boolean
  end
end
