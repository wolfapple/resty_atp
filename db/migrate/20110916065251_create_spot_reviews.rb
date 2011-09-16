# -*- encoding : utf-8 -*-
class CreateSpotReviews < ActiveRecord::Migration
  def change
    create_table :spot_reviews do |t|
      t.references :spot
      t.text :content

      t.timestamps
    end
    add_index :spot_reviews, :spot_id
  end
end
