# -*- encoding : utf-8 -*-
class CreateSpotPensions < ActiveRecord::Migration
  def change
    create_table :spot_pensions do |t|
      t.references :spot
      t.references :pension
      t.integer :reviews_count

      t.timestamps
    end
    add_index :spot_pensions, :spot_id
    add_index :spot_pensions, :pension_id
  end
end
