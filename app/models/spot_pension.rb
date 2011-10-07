# -*- encoding : utf-8 -*-
class SpotPension < ActiveRecord::Base
  belongs_to :spot
  belongs_to :pension
  
  validates_presence_of :spot_id, :pension_id
  validates_uniqueness_of :spot_id, :scope => [:pension_id]
end
