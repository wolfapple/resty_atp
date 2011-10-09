# -*- encoding : utf-8 -*-
class Pension < ActiveRecord::Base
  has_many :reviews, :class_name => "PensionReview"
  has_many :rooms
  has_many :theme_pensions
  has_many :themes, :through => :theme_pensions
  has_one :must_visit
  belongs_to :area
  belongs_to :sub_area
  mount_uploader :thumbnail, PensionImageUploader
  
  default_scope order('ranking desc')
  scope :uncategorized, where('area_id = 0 or sub_area_id = 0')
  
  def near_by
    pensions = self.sub_area.pensions.where("id <> ?", self.id).where("addr like '#{self.addr.split(' ')[2]}'").limit(5)
    pensoins = pensions + self.sub_area.pensions.where("id <> ?", self.id).limit(5-pensions.count) if pensions.count < 5
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
