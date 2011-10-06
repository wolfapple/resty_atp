# -*- encoding : utf-8 -*-
class MustVisit < ActiveRecord::Base
  belongs_to :pension
  
  validates_presence_of :pension_id
  validates_uniqueness_of :pension_id
  
  scope :main, order('rand()').limit(10)
end
