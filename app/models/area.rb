# -*- encoding : utf-8 -*-
class Area < ActiveRecord::Base
  has_many :sub_areas
  has_many :pensions
  has_many :area_spots
  has_many :spots
  
  validates_presence_of :title
  
  scope :main, where(:is_main => true).order('pensions_count desc')
end
