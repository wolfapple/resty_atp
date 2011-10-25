# -*- encoding : utf-8 -*-
ActiveAdmin.register Pension do
  menu :label => '펜션'
  
  scope 'ToDo', :uncategorized
  
  index do
    column '지역1', :area, :sortable => :area_id
    column '지역2', :sub_area, :sortable => :sub_area_id
    column '썸네일' do |pension|
      image_tag pension.list_img
    end
    column '펜션명', :title
    column 'URL', :url
    column '주소', :addr
    column '가격', :min_price
    column '전화번호', :mobile
    column '객실정보' do |pension|
      pension.rooms.count > 0 ? 'O' : 'X'
    end
    column 'must' do |pension|
      link_to 'must', new_admin_must_visit_path('must_visit[pension_id]' => pension.id) unless pension.must_visit
    end
    default_actions
  end
  
  form :html => {:multipart => true} do |f|
    f.inputs  do
      f.input :area
      f.input :sub_area
      f.input :title
      f.input :url
      f.input :addr
      f.input :mobile
      f.input :roomstructure
      f.input :min_price
      f.input :max_price
      f.input :thumbnail, :as => :file
      f.input :remove_thumbnail, :as => :boolean
      f.input :room_table, :as => :file
      f.input :remove_room_table, :as => :boolean
      f.input :ranking
    end
    f.inputs "시설 정보" do
      f.input :facility_names, :as => :check_boxes, :collection => Facility.all.collect{|x| x.title}, :label => '시설'
    end
    f.inputs "테마 정보" do  
      f.input :themes, :as => :check_boxes, :collection => Theme.all, :label => '테마'
    end
    f.buttons
  end
end
