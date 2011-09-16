# -*- encoding : utf-8 -*-
class SpotPension < ActiveRecord::Base
  belongs_to :spot
  belongs_to :pension
end
