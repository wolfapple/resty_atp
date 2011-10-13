class AddLatitudeAndLongitudeToPensions < ActiveRecord::Migration
  def change
    add_column :pensions, :latitude, :string
    add_column :pensions, :longitude, :string
    Pension.all.each do |pension|
      pension.update_attributes({:longitude => pension.locationx, :latitude => pension.locationy})
    end
  end
end
