# -*- encoding : utf-8 -*-
class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|
      t.string :title
      t.integer :lat
      t.integer :lng
      t.integer :pensions_count

      t.timestamps
    end
  end
end
