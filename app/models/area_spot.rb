# -*- encoding : utf-8 -*-
class AreaSpot < ActiveRecord::Base
  belongs_to :area
  belongs_to :sub_area
  belongs_to :spot
end
