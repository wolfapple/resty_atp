# -*- encoding : utf-8 -*-
class Pension < ActiveRecord::Base
  has_many :reviews, :class_name => "PensionReview"
  has_many :rooms
  has_many :theme_pensions, :dependent => :destroy
  has_many :themes, :through => :theme_pensions
  has_one :must_visit, :dependent => :destroy
  has_one :coupon, :dependent => :destroy, :conditions => ['is_valid = 1 and end_at > now()']
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
  # task
  after_validation :task_done, :if => :addr_changed? or :mobile_changed? or :min_price_changed? or :max_price_changed? or :thumbnail_changed? or :room_table_changed? or :facility_names_changed?
  # scope
  default_scope order('ranking desc')
  scope :task1, where(:address02 => 'task1')
  scope :task2, where(:address02 => 'task2')
  scope :task3, where(:address02 => 'task3')
  
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
