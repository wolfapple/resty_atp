# -*- encoding : utf-8 -*-
class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :title
      t.integer :pensions_count

      t.timestamps
    end
  end
end
