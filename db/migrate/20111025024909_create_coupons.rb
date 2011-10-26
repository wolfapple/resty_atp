# -*- encoding : utf-8 -*-
class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.references :pension
      t.string :provider
      t.string :title
      t.string :image
      t.string :link
      t.integer :org_price
      t.integer :dis_price
      t.integer :disrate
      t.datetime :start_at
      t.datetime :end_at
      t.boolean :is_valid, :default => false

      t.timestamps
    end
    add_index :coupons, :pension_id
  end
end
