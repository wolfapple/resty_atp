# -*- encoding : utf-8 -*-
ActiveAdmin.register SubArea do
  menu :label => '지역2'
  
  index do
    column '지역명', :title
    column '펜션수', :pensions_count
    default_actions
  end
end
