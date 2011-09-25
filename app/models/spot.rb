# -*- encoding : utf-8 -*-
class Spot < ActiveRecord::Base
  has_many :spot_pensions
  has_many :pensions, :through => :spot_pensions
  has_many :reviews, :class_name => "SpotReview"
  has_one :area_spot
  has_one :area, :through => :area_spot
  has_one :sub_area, :through => :area_spot
end
