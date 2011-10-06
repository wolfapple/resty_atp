# -*- encoding : utf-8 -*-
class CreateSubAreas < ActiveRecord::Migration
  def change
    create_table :sub_areas do |t|
      t.references :area
      t.string :title
      t.boolean :is_main, :default => false
      t.integer :pensions_count

      t.timestamps
    end
    add_index :sub_areas, :area_id
  end
end
