# -*- encoding : utf-8 -*-
ActiveAdmin.register SpotPension do
  menu :label => '여행지별 펜션'
  
  index do
    column '여행', :spot, :sortable => :spot_id
    column '펜션', :pension, :sortable => :pension_id
    column '주소' do |spot|
      spot.pension.addr
    end
    column 'URL' do |spot|
      spot.pension.url
    end
  end
end
