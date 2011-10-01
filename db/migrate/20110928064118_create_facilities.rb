class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.string :title
      t.integer :pensions_count

      t.timestamps
    end
  end
end
