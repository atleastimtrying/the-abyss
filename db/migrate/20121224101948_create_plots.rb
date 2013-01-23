class CreatePlots < ActiveRecord::Migration
  def change
    create_table :plots do |t|
      t.string :title
      t.string :state
      t.text :description
      t.integer :x
      t.integer :y
      t.integer :user_id
      t.timestamps
    end
  end
end
