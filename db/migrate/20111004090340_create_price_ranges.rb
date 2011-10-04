# -*- encoding : utf-8 -*-
class CreatePriceRanges < ActiveRecord::Migration
  def change
    create_table :price_ranges do |t|
      t.integer :min
      t.integer :max

      t.timestamps
    end
  end
end
