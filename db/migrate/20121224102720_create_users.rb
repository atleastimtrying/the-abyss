class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.text :password
      t.text :email
      t.integer :x
      t.integer :y

      t.timestamps
    end
  end
end
