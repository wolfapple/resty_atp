# -*- encoding : utf-8 -*-
class CreateThemes < ActiveRecord::Migration
  def change
    create_table :themes do |t|
      t.string :title
      t.string :img
      t.integer :pensions_count

      t.timestamps
    end
  end
end
