# -*- encoding : utf-8 -*-
class ThemePension < ActiveRecord::Base
  belongs_to :theme
  belongs_to :pension
  
  validates_presence_of :theme_id, :pension_id
  validates_uniqueness_of :theme_id, :pension_id
end
