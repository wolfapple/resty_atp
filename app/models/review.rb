# -*- encoding : utf-8 -*-
class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :pension
end
