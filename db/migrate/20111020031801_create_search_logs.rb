# -*- encoding : utf-8 -*-
class CreateSearchLogs < ActiveRecord::Migration
  def change
    create_table :search_logs do |t|
      t.string :input
      t.integer :count, :default => 0

      t.timestamps
    end
  end
end
