# -*- encoding : utf-8 -*-
class AddLatitudeAndLongitudeToPensions < ActiveRecord::Migration
  def change
    add_column :pensions, :latitude, :float, :limit => 53
    add_column :pensions, :longitude, :float, :limit => 53
  end
end
