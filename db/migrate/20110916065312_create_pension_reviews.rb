# -*- encoding : utf-8 -*-
class CreatePensionReviews < ActiveRecord::Migration
  def change
    create_table :pension_reviews do |t|
      t.references :user
      t.references :pension
      t.text :content

      t.timestamps
    end
    add_index :pension_reviews, :user_id
    add_index :pension_reviews, :pension_id
  end
end
