# -*- encoding : utf-8 -*-
class CreatePensionReviews < ActiveRecord::Migration
  def change
    create_table :pension_reviews do |t|
      t.references :user
      t.references :pension
      t.integer :overall
      t.string :title
      t.string :content
      t.integer :clean
      t.integer :kindness
      t.integer :price
      t.integer :location
      t.integer :interior
      t.integer :helpful, :default => 0

      t.timestamps
    end
    add_index :pension_reviews, :user_id
    add_index :pension_reviews, :pension_id
  end
end
