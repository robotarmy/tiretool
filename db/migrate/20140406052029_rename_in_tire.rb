class RenameInTire < ActiveRecord::Migration
  def change
    rename_column :tires, :width,    :width_mm
    rename_column :tires, :rim_size, :rim_inches
  end
end
