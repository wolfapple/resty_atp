class CreateAreaSpots < ActiveRecord::Migration
  def change
    create_table :area_spots do |t|
      t.references :area
      t.references :sub_area
      t.references :spot

      t.timestamps
    end
    add_index :area_spots, :area_id
    add_index :area_spots, :sub_area_id
    add_index :area_spots, :spot_id
  end
end
