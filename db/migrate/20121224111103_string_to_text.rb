class StringToText < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.change :password, :string
      t.change :email, :string
    end
  end
end
