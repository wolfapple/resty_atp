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
  
  def sub_addr
    temp = addr.split(' ')
    if temp[1][-1] == '시' or temp[1][-1] == '군'
      temp[1][0..-2]
    else
      temp[0]
    end
  end
  
  def pensions
    Pension.near([self.latitude, self.longitude], 10, {:units => :km})
  end
    
  def near_by_pensions(limit=nil)
    if limit.nil?
      Pension.unscoped.near([self.latitude, self.longitude], 10, {:units => :km, :order => :distance})
    else
      Pension.unscoped.near([self.latitude, self.longitude], 10, {:units => :km, :order => :distance, :limit => limit})
    end
  end
  
  def html
    "<h3>#{self.title}</h3>
    <div><p><img src='/assets/address_icon.png'>&nbsp;#{self.addr}</p>
    <p><img src='/assets/phone_icon.png'>&nbsp;#{self.phone}</p>
    <p class='link'><a href='/spots/#{self.id}' target='_blank'>여행지 바로가기</a></p></div>"
  end
  
  private
  def update_pensions_count
    self.pensions_count = self.pensions.length
  end
end
