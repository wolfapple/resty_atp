# -*- encoding : utf-8 -*-
class CreatePensions < ActiveRecord::Migration
  def change
    create_table :pensions do |t|
      t.references :area
      t.references :sub_area
      t.string :title
      t.string :url
      t.string :addr
      t.string :mobile
      t.string :phone
      t.string :phone2
      t.string :email
      t.string :manager
      t.integer :rating
      t.string :summary
      t.string :rooms_count
      t.string :room_structure
      t.integer :min_price
      t.integer :max_price
      t.string :season_info
      t.string :checkin
      t.string :service_charge
      t.string :tax_include
      t.string :lat
      t.string :lng
      t.string :credit_card
      t.string :pet
      t.string :breakfast
      t.string :foreign_language
      t.string :pickup
      t.string :parking
      t.string :facilities
      t.string :facilities2
      t.string :foodcourt
      t.string :baby
      t.integer :like_count
      t.integer :reviews_count, :default => 0

      t.timestamps
    end
    add_index :pensions, :area_id
    add_index :pensions, :sub_area_id
  end
end
