# -*- encoding : utf-8 -*-
class AddLatitudeAndLongitudeToSpots < ActiveRecord::Migration
  def change
    add_column :spots, :latitude, :float, :limit => 53
    add_column :spots, :longitude, :float, :limit => 53
  end
end
