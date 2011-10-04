# -*- encoding : utf-8 -*-
class PriceRange < ActiveRecord::Base
  def to_s
    if self.min == 0
      price_str = "#{self.max}만원 이하"
    elsif self.max == 0
      price_str = "#{self.min}만원 이상"
    else
      price_str = "#{self.min}만원 ~ #{self.max}만원"
    end
  end
  
  def min_price
    self.min * 10000
  end
  
  def max_price
    self.max * 10000
  end
end
