class CreateDiscs < ActiveRecord::Migration
  def change
    create_table :discs do |t|
      t.string :name
      t.string :color
      t.integer :weight 
      t.integer :user_id 
    end 
  end
end
