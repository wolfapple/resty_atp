# -*- encoding : utf-8 -*-
class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :title
      t.text :content
      t.string :pension_name
      t.string :pension_url

      t.timestamps
    end
  end
end
