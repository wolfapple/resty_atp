# -*- encoding : utf-8 -*-
class PriceRange < ActiveRecord::Base
  validates_presence_of :min, :max
  validates_numericality_of :min, :max
  
  def to_s
    if self.min == 0
      price_str = "#{self.max / 10000}만원 이하"
    elsif self.max == 0
      price_str = "#{self.min / 10000}만원 이상"
    else
      price_str = "#{self.min / 10000}만원 ~ #{self.max / 10000}만원"
    end
  end
end
