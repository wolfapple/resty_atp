# -*- encoding : utf-8 -*-
ActiveAdmin.register MustVisit do
  menu :label => 'Must Visit'
  
  index do
    column '펜션', :pension, :sortable => :pension_id
    column 'URL' do |must_visit|
      must_visit.pension.url
    end
  end
end
