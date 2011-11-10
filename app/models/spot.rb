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
  # pension count
  after_validation :update_pensions_count, :if => :is_main
  
  default_scope order('pensions_count desc')
  scope :uncategorized, where('area_id = 0 or sub_area_id = 0')
  scope :main, reorder('rand()').limit(8)
  
  def pensions
    Pension.near([self.latitude, self.longitude], 10, {:units => :km})
  end
    
  def near_by_pensions
    Pension.unscoped.near([self.latitude, self.longitude], 10, {:units => :km, :order => :distance, :limit => 15})
  end
  
  def html(mobile=false)
    if mobile
      "<h4 style='margin-top: 0px'><a href='/spots/#{self.id}'>#{self.title}</a></h4>"
    else
      "<h3 style='margin-top: 0px'>#{self.title}</h3><a href='/spots/#{self.id}' target='_blank'>여행지 바로가기</a>"
    end
  end
  
  private
  def update_pensions_count
    self.pensions_count = self.pensions.length
  end
end
