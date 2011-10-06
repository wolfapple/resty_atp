# -*- encoding : utf-8 -*-
class Theme < ActiveRecord::Base
  has_many :theme_pensions
  has_many :pensions, :through => :theme_pensions
  
  validates_presence_of :title
end
