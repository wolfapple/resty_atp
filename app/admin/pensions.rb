# -*- encoding : utf-8 -*-
ActiveAdmin.register Pension do
  menu :label => '펜션'
  
  1.upto 48 do |num|
    scope "task#{num}", "task#{num}"
  end
  
  index do
    column '지역1', :area, :sortable => :area_id
    column '지역2', :sub_area, :sortable => :sub_area_id
    column '썸네일' do |pension|
      link_to image_tag(pension.list_img), edit_admin_pension_path(pension), :target => '_blank'
    end
    column '펜션명' do |pension|
      link_to pension.title, edit_admin_pension_path(pension), :target => '_blank'
    end
    column 'URL' do |pension|
      link_to pension.url, pension.url, :target => '_blank'
    end
    column '주소', :addr
    column '가격', :min_price
    column '전화번호', :mobile
    column '객실정보' do |pension|
      if pension.rooms.count > 0 or !pension.room_table.file.nil?
        'O'
      else
        'X'
      end
    end
    column 'must' do |pension|
      link_to 'must', new_admin_must_visit_path('must_visit[pension_id]' => pension.id) unless pension.must_visit
    end
    default_actions if current_admin_user.email == 'resty@resty.co.kr'
  end
  
  form :html => {:multipart => true} do |f|
    f.inputs  do
      f.input :area
      f.input :sub_area
      f.input :title
      f.input :url
      f.input :addr
      f.input :mobile
      f.input :roomstructure_names, :as => :check_boxes, :collection => ['커플', '가족', '단체', '워크샵'], :label => 'roomstructure'
      f.input :min_price
      f.input :max_price
      f.input :thumbnail, :as => :file
      f.input :remove_thumbnail, :as => :boolean
      f.input :room_table, :as => :file
      f.input :remove_room_table, :as => :boolean
      f.input :comments_count
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
