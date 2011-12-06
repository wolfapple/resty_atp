# -*- encoding : utf-8 -*-
class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|
      t.references :area
      t.references :sub_area
      t.string :title
      t.string :addr
      t.string :phone
      t.text :description
      t.string :url
      t.boolean :is_main, :default => false
      t.boolean :is_season, :default => false
      t.integer :pensions_count, :default => 0
      t.integer :comments_count, :default => 0
      t.integer :like_count, :default => 0
      t.integer :reviews_count, :default => 0
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
