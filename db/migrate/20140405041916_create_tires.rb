class CreateTires < ActiveRecord::Migration
  def change
    create_table :tires do |t|
      t.integer :width
      t.integer :profile
      t.integer :rim_size
      t.string :speed_rating

      t.timestamps
    end
  end
end
