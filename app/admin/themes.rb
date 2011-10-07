# -*- encoding : utf-8 -*-
ActiveAdmin.register Theme do
  menu :label => '테마'
  
  index do
    column :title
    column '펜션수', :pensions_count
  end
end
