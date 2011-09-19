# -*- encoding : utf-8 -*-
class PensionReview < ActiveRecord::Base
  belongs_to :pension, :counter_cache => :reviews_count
  
  default_scope order('id desc')
end
