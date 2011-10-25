# -*- encoding : utf-8 -*-
class Pension < ActiveRecord::Base
  has_many :reviews, :class_name => "PensionReview"
  has_many :rooms
  has_many :theme_pensions, :dependent => :destroy
  has_many :themes, :through => :theme_pensions
  has_one :must_visit, :dependent => :destroy
  belongs_to :area
  belongs_to :sub_area
  # facilities
  attr_accessor :facility_names
  after_validation :assign_facilities
  # upload
  mount_uploader :thumbnail, PensionImageUploader
  mount_uploader :room_table, RoomTableUploader
  # geocode
  geocoded_by :addr
  after_validation :geocode, :if => :addr_changed?
  # scope
  default_scope order('ranking desc')
  scope :uncategorized, where(:address02 => 'N')
  
  def near_by
    Pension.unscoped.where("id <> ?", self.id).near(self, 10, {:units => :km, :order => :distance, :limit => 15})
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
  
  def html
    "<h3 style='margin-top: 0px'>#{self.title}</h3><a href='/pensions/#{self.id}' target='_blank'>펜션 바로가기</a>"
  end
  
  def html_list
    "<h3 style='margin-top: 0px'>#{self.title}</h3><a href='#pension-#{self.id}' onclick='highlight_pension(#{self.id})'>리스트로 바로가기</a>"
  end
    
  def facility_names
    if facilities.blank?
      temp = []
    else
      temp = facilities.split(',')
    end
    @facility_names || temp
  end
  
  private
  def assign_facilities
    if @facility_names
      @facility_names.delete('')
      self.facilities = @facility_names.join(',')
    end
  end
end
