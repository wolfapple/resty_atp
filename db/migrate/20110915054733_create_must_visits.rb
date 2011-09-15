# -*- encoding : utf-8 -*-
class CreateMustVisits < ActiveRecord::Migration
  def change
    create_table :must_visits do |t|
      t.references :pension
      t.string :title
      t.string :img

      t.timestamps
    end
    add_index :must_visits, :pension_id
  end
end
