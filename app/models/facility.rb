# -*- encoding : utf-8 -*-
class Facility < ActiveRecord::Base
  validates_presence_of :title
end
