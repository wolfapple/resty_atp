# -*- encoding : utf-8 -*-
class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gender, :string, :limit => 1
    add_column :users, :age , :integer
    add_column :users, :area, :string
    add_column :users, :email_agree, :boolean, :default => true
  end
end
