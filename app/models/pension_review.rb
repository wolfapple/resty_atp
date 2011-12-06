# -*- encoding : utf-8 -*-
class PensionReview < ActiveRecord::Base
  belongs_to :user
  belongs_to :pension, :counter_cache => :reviews_count
  
  default_scope order('id desc')
  
  validates_presence_of :content, :message => '리뷰 내용을 입력해 주세요.'
  validates_presence_of :pension_id, :user_id, :message => '잘못된 접근입니다.'
end
