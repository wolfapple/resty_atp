# -*- encoding : utf-8 -*-
class CreateThemePensions < ActiveRecord::Migration
  def change
    create_table :theme_pensions do |t|
      t.references :theme
      t.references :pension

      t.timestamps
    end
    add_index :theme_pensions, :theme_id
    add_index :theme_pensions, :pension_id
  end
end
