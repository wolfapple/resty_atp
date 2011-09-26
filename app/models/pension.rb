# -*- encoding : utf-8 -*-
class Pension < ActiveRecord::Base
  has_many :reviews, :class_name => "PensionReview"
  has_many :rooms
  has_many :theme_pensions
  has_many :themes, :through => :theme_pensions
  has_one :must_visit
  belongs_to :area
  belongs_to :sub_area
  
  scope :uncategorized, where('area_id is null or sub_area_id is null')
  scope :by_addr1, lambda { |addr| where(:addr1 => addr) }
  scope :by_addr2, lambda { |addr| where(:addr2 => addr) }
  
  def self.addrs
    self.select('DISTINCT(addr1)').order('addr1').map { |addr| addr.addr1 }
  end
  
  def self.sub_addrs(addr)
    self.where(:addr1 => addr).select('DISTINCT(addr2)').order('addr2').map { |addr| addr.addr2 }
  end
end
