# -*- encoding : utf-8 -*-
class Spot < ActiveRecord::Base
  has_many :spot_pensions
  has_many :pensions, :through => :spot_pensions
  has_many :reviews, :class_name => "SpotReview"
  belongs_to :area
  belongs_to :sub_area
  
  validates_presence_of :title
  
  scope :uncategorized, where('area_id = 0 or sub_area_id = 0')
  scope :main, where(:is_main => true)
  scope :by_area, order('pensions_count desc').limit(10)
  scope :by_sub_area, order('pensions_count desc').limit(10)
  
  def near_by_pensions
    pensions = self.pensions.where("addr like '#{self.addr.split(' ')[2]}'").limit(5)
    pensions = pensions + self.pensions.limit(5-pensions.count) if pensions.count < 5
  end
end
