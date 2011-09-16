# -*- encoding : utf-8 -*-
class ThemePension < ActiveRecord::Base
  belongs_to :theme
  belongs_to :pension
end
