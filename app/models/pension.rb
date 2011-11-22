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
  # facilities & roomstructure
  attr_accessor :facility_names
  after_validation :assign_facilities
  attr_accessor :roomstructure_names
  after_validation :assign_roomstructure
  # auto theme add
  after_update :auto_theme
  # price fix
  after_validation :price_fix
  # upload
  mount_uploader :thumbnail, PensionImageUploader
  mount_uploader :room_table, RoomTableUploader
  # geocode
  geocoded_by :addr
  after_validation :geocode, :if => :addr_changed?
  # scope
  default_scope order('ranking desc')
  1.upto 48 do |num|
    scope "task#{num}", where(:address02 => "task#{num}")
  end
  
  def near_by(limit=nil)
    if limit.nil?  
      Pension.unscoped.where("id <> ?", self.id).near(self, 10, {:units => :km, :order => :distance})
    else
      Pension.unscoped.where("id <> ?", self.id).near(self, 10, {:units => :km, :order => :distance, :limit => limit})
    end
  end
  
  def short_addr
    self.addr.split(' ')[0..2].join(' ')
  end
  
  def sub_addr
    temp = addr.split(' ')
    if temp[1][-1] == '시' or temp[1][-1] == '군'
      temp[1][0..-2]
    else
      temp[0]
    end
  end
  
  def list_img
    if Rails.env == "development"
      "/assets/thumb_pension_photo_noimage.jpg"
    elsif self.thumbnail.url.index('http:/')
      'http://' + self.thumbnail.url.split('http:/')[1]
    else
      self.thumbnail.thumb.url
    end
  end
  
  def show_img
    if Rails.env == "development"
      "/assets/thumb_pension_photo_noimage.jpg"
    elsif self.thumbnail.url.index('http:/')
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
    "<h3>#{self.title}</h3>
    <img src='#{self.list_img}' class='thumbnail'>
    <div><p><img src='/assets/address_icon.png'>&nbsp;#{self.addr}</p>
    <p><img src='/assets/phone_icon.png'>&nbsp;#{self.mobile}</p>
    <p class='link'><a href='/pensions/#{self.id}' target='_blank'>펜션 바로가기</a></p></div>"
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
  
  def roomstructure_names
    if roomstructure.blank?
      temp = []
    else
      temp = roomstructure.split(',').collect {|x| x.strip}
    end
    @roomstrucutre_names || temp
  end
  
  private
  def assign_facilities
    if @facility_names
      @facility_names.delete('')
      self.facilities = @facility_names.join(',')
    end
  end
  
  def assign_roomstructure
    if @roomstructure_names
      @roomstructure_names.delete('')
      self.roomstructure = @roomstructure_names.join(',')
    end
  end
  
  def auto_theme
    unless roomstructure.blank?
      room_arr = roomstructure.split(',').collect {|x| x.strip}
      ThemePension.find_or_create_by_theme_id_and_pension_id Theme.find_by_title('커플').id, self.id if room_arr.include? '커플'
      ThemePension.find_or_create_by_theme_id_and_pension_id Theme.find_by_title('워크샵').id, self.id if room_arr.include? '워크샵'
    end
    unless facilities.blank?      
      facility_arr = facilities.split(',').collect {|x| x.strip}
      ThemePension.find_or_create_by_theme_id_and_pension_id Theme.find_by_title('스파/월풀').id, self.id if facility_arr.include? '스파/월풀'
      ThemePension.find_or_create_by_theme_id_and_pension_id Theme.find_by_title('수영장').id, self.id if facility_arr.include? '수영장'
      ThemePension.find_or_create_by_theme_id_and_pension_id Theme.find_by_title('카페').id, self.id if facility_arr.include? '카페'
      ThemePension.find_or_create_by_theme_id_and_pension_id Theme.find_by_title('자전거').id, self.id if facility_arr.include? '자전거'
    end
    ThemePension.find_or_create_by_theme_id_and_pension_id Theme.find_by_title('10만원이하').id, self.id if min_price <= 100000 and min_price > 0
  end
  
  def price_fix
    self.min_price = min_price * 10000 if !min_price.blank? and min_price < 1000
    self.max_price = max_price * 10000 if !max_price.blank? and max_price < 1000
  end
end
