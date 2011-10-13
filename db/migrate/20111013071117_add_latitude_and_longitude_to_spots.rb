class AddLatitudeAndLongitudeToSpots < ActiveRecord::Migration
  def change
    add_column :spots, :latitude, :string
    add_column :spots, :longitude, :string
  end
end
