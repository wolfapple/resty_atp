# -*- encoding : utf-8 -*-
ActiveAdmin.register Spot do
  menu :label => '여행지'
  
  scope '미분류', :uncategorized
  
  index do
    column '지역1', :area, :sortable => :area_id
    column '지역2', :sub_area, :sortable => :sub_area_id
    column '여행지명', :title
    column '전화번호', :phone
    column '주소', :addr
    column 'URL', :url
    column '메인노출', :is_main
    default_actions
  end
end
