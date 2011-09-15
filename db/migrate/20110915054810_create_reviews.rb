# -*- encoding : utf-8 -*-
class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :user
      t.references :pension
      t.text :content

      t.timestamps
    end
    add_index :reviews, :user_id
    add_index :reviews, :pension_id
  end
end
