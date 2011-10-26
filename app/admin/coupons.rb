# -*- encoding : utf-8 -*-
ActiveAdmin.register Coupon do
  menu :label => '소셜커머스'
  
  scope 'invalid', :invalid
  
  index do
    column '펜션', :pension, :sortable => :pension_id
    column '이미지' do |coupon|
      image_tag coupon.image, :width => '300px'
    end
    column '타이틀', :title
    column '링크', :link
    column '매칭여부', :is_valid
    default_actions
  end
end
