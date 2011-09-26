# -*- encoding : utf-8 -*-
class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.references :pension
      t.string :title
      t.string :type
      t.string :area
      t.string :price
      t.string :additional_price
      t.string :facilities
      t.string :facilities2
      t.string :number
      t.string :desc
      t.string :desc2
      t.string :season_info
      t.string :image

      t.timestamps
    end
    add_index :rooms, :pension_id
  end
end
