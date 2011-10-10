# -*- encoding : utf-8 -*-
ActiveAdmin.register PriceRange do
  menu :label => '가격대'
  
  index do
    column '최저가', :min
    column '최대가', :max
    default_actions
  end
end
