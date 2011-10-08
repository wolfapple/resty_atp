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
    column 'must' do |pension|
      link_to 'must', new_admin_must_visit_path('must_visit[pension_id]' => pension.id) unless pension.must_visit
    end
    column 'theme' do |pension|
      link_to 'theme', new_admin_theme_pension_path('theme_pension[pension_id]' => pension.id)
    end
    default_actions
  end
  
  form :html => {:multipart => true} do |f|
    f.inputs "pension details" do
      f.input :area
      f.input :sub_area
      f.input :title
      f.input :url
      f.input :addr
      f.input :mobile
      f.input :roomstructure
      f.input :min_price
      f.input :max_price
      f.input :facilities
      f.input :thumbnail, :as => :file
      f.input :ranking
    end
    f.buttons
  end
end
