# -*- encoding : utf-8 -*-
class Pension < ActiveRecord::Base
  has_many :reviews, :class_name => "PensionReview"
  has_many :rooms
  has_many :theme_pensions, :dependent => :destroy
  has_many :themes, :through => :theme_pensions
  has_one :must_visit, :dependent => :destroy
  belongs_to :area
  belongs_to :sub_area
  # upload
  mount_uploader :thumbnail, PensionImageUploader
  # geocode
  geocoded_by :addr
  after_validation :geocode, :if => :addr_changed?
  # scope
  default_scope order('ranking desc')
  scope :uncategorized, where('area_id = 0 or sub_area_id = 0')
  
  def near_by(limit=7)
    pensions = self.sub_area.pensions.where("id <> ?", self.id).where("addr like '#{self.addr.split(' ')[2]}'").limit(limit)
    pensoins = pensions + self.sub_area.pensions.where("id <> ?", self.id).limit(limit-pensions.count) if pensions.count < limit
  end
  
  def short_addr
    self.addr.split(' ')[0..2].join(' ')
  end
  
  def list_img
    if self.thumbnail.url.index('http:/')
      'http://' + self.thumbnail.url.split('http:/')[1]
    else
      self.thumbnail.thumb.url
    end
  end
  
  def show_img
    if self.thumbnail.url.index('http:/')
      'http://' + self.thumbnail.url.split('http:/')[1]
    else
      self.thumbnail.url
    end
  end
  
  def og_img
    if self.thumbnail.url.index('http:/')
      'http://' + self.thumbnail.url.split('http:/')[1]
    else
      'http://www.resty.co.kr' + self.thumbnail.url
    end
  end
end
