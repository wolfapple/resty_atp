# -*- encoding : utf-8 -*-
class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.references :pension
      t.string :title

      t.timestamps
    end
    add_index :rooms, :pension_id
  end
end
