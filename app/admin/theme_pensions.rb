# -*- encoding : utf-8 -*-
ActiveAdmin.register ThemePension do
  menu :label => '테마별 펜션'
  
  index do
    column '테마', :theme, :sortable => :theme_id
    column '펜션', :pension, :sortable => :pension_id
    column 'URL' do |theme|
      theme.pension.url
    end
  end
end
