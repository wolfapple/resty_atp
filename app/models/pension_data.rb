# -*- encoding : utf-8 -*-
class PensionData < ActiveRecord::Base
  set_table_name 'pensiondata'
  has_many :rooms, :class_name => "PensionChamber", :foreign_key => "pensiondataid"
end
