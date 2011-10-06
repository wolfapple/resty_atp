# -*- encoding : utf-8 -*-
class Spot < ActiveRecord::Base
  has_many :spot_pensions
  has_many :pensions, :through => :spot_pensions
  has_many :reviews, :class_name => "SpotReview"
  belongs_to :area
  belongs_to :sub_area
  
  validates_presence_of :title
  
  scope :uncategorized, where('area_id = 0 or sub_area_id = 0')
  scope :main, where(:is_main => true)
end
