# -*- encoding : utf-8 -*-
class SpotReview < ActiveRecord::Base
  belongs_to :spot, :counter_cache => :reviews_count
  
  default_scope order('id desc')
end
