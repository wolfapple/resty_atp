# -*- encoding : utf-8 -*-
ActiveAdmin.register SubArea do
  menu :label => '지역2'
  
  index do
    column '지역명', :title
    column '펜션수', :pensions_count
    column '메인노출', :is_main
    default_actions
  end
end
