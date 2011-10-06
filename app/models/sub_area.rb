# -*- encoding : utf-8 -*-
class SubArea < ActiveRecord::Base
  belongs_to :area
  has_many :pensions
  has_many :area_spots
  has_many :spots, :through => :area_spots
  
  scope :main, where(:is_main => true)
end
