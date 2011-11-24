class CreatePensionLogs < ActiveRecord::Migration
  def change
    create_table :pension_logs do |t|
      t.references :area
      t.references :sub_area
      t.references :pension
      t.date :created_at
      t.integer :count, :default => 0
    end
    add_index :pension_logs, :area_id
    add_index :pension_logs, :sub_area_id
    add_index :pension_logs, :pension_id
  end
end
