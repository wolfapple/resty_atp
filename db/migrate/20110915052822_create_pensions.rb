# -*- encoding : utf-8 -*-
class CreatePensions < ActiveRecord::Migration
  def change
    create_table :pensions do |t|
      t.references :area
      t.references :sub_area
      t.string :title
      t.string :addr1
      t.string :addr2
      t.string :addr
      t.string :phone
      t.string :lat
      t.string :lng
      t.integer :min_price
      t.integer :max_price
      t.integer :like_count
      t.integer :reviews_count, :default => 0

      t.timestamps
    end
    add_index :pensions, :area_id
    add_index :pensions, :sub_area_id
  end
end
