class AddExtraToTire < ActiveRecord::Migration
  def change
    add_column :tires, :sidewall_mm, :float
    add_column :tires, :height_mm, :float
    add_column :tires, :notes, :text
  end
end
