# -*- encoding : utf-8 -*-
ActiveAdmin.register Pension do
  menu :label => '펜션'
  
  scope '미분류', :uncategorized
  
  index do
    column '지역1', :area, :sortable => :area_id
    column '지역2', :sub_area, :sortable => :sub_area_id
    column '펜션명', :title
    column 'URL', :url
    column '주소', :addr
    column '랭킹', :ranking
    default_actions
  end
end
