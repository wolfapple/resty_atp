# -*- encoding : utf-8 -*-
class Spot < ActiveRecord::Base
  has_many :spot_pensions
  has_many :pensions, :through => :spot_pensions
  has_many :reviews, :class_name => "SpotReview"
  belongs_to :area
  belongs_to :sub_area
  # validation
  validates_presence_of :title
  # geocode
  geocoded_by :addr
  after_validation :geocode, :if => :addr_changed?
  
  default_scope order('pensions_count desc')
  scope :uncategorized, where('area_id = 0 or sub_area_id = 0')
  scope :main, where(:is_main => true)
    
  def near_by_pensions(limit=7)
    #pensions = self.pensions.where("addr like '#{self.addr.split(' ')[2]}'").limit(limit)
    #pensions = pensions + self.pensions.limit(limit-pensions.count) if pensions.count < limit
    Pension.unscoped.near([self.latitude, self.longitude], 10, {:units => :km, :order => :distance, :limit => 15})
  end
  
  def html
    "<h3 style='margin-top: 0px'>#{self.title}</h3><a href='/spots/#{self.id}' target='_blank'>여행지 바로가기</a>"
  end
end
