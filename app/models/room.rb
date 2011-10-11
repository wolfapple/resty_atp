# -*- encoding : utf-8 -*-
class Room < ActiveRecord::Base
  belongs_to :pension
  
  def img
    self.imageurl ? self.imageurl : 'thumb_pension_photo_noimage.jpg'
  end
end
