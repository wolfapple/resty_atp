# -*- encoding : utf-8 -*-
class Area < ActiveRecord::Base
  has_many :sub_areas, :conditions => "pensions_count > 0"
  has_many :pensions
  has_many :area_spots
  has_many :spots, :through => :area_spots
end
