# -*- encoding : utf-8 -*-
class Theme < ActiveRecord::Base
  has_many :theme_pensions
  has_many :pensions, :through => :theme_pensions
end
