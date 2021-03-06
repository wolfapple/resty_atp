# -*- encoding : utf-8 -*-
class MustVisit < ActiveRecord::Base
  belongs_to :pension  
  mount_uploader :img, MustVisitImageUploader
  
  validates_presence_of :pension_id
  validates_uniqueness_of :pension_id
  
  scope :main, order('rand()').limit(10)
  
  def image
    if Rails.env == "development"
      "http://www.resty.co.kr#{self.img.url}"
    else
      self.img.url
    end
  end
end
