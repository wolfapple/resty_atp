# -*- encoding : utf-8 -*-
class AddLatitudeAndLongitudeToPensions < ActiveRecord::Migration
  def change
    add_column :pensions, :latitude, :float
    add_column :pensions, :longitude, :float
  end
end
