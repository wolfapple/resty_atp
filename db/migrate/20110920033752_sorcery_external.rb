# -*- encoding : utf-8 -*-
class SorceryExternal < ActiveRecord::Migration
  def self.up
    create_table :user_providers do |t|
      t.integer :user_id, :null => false
      t.string :provider, :uid, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :user_providers
  end
end
