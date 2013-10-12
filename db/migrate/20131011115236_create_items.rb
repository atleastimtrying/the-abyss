class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :x
      t.integer :y
      t.string :title
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end
end
