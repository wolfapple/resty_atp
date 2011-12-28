# -*- encoding : utf-8 -*-
class PensionReview < ActiveRecord::Base
  belongs_to :user
  belongs_to :pension, :counter_cache => :reviews_count
  
  default_scope order('helpful desc, id desc')

  validates_presence_of :title, :content, :message => '내용을 입력해 주세요.'
  validates_length_of :content, :maximum => 400, :message => '최대 400자까지 가능합니다.'
  validates_presence_of :pension_id, :user_id, :message => '잘못된 접근입니다.'
  validates_presence_of :overall, :clean, :kindness, :price, :location, :interior, :message => "평가를 해주세요."
  validates_inclusion_of :overall, :clean, :kindness, :price, :location, :interior, :in => 1..5, :message => "잘못된 별점입니다."
end
