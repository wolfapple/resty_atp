# -*- encoding : utf-8 -*-
ActiveAdmin.register MustVisit do
  menu :label => 'Must Visit'
  
  index do
    column '펜션', :pension, :sortable => :pension_id
    column 'URL' do |must_visit|
      must_visit.pension.url
    end
    default_actions
  end
  
  form :html => {:multipart => true} do |f|
    f.inputs "Must Visit" do
      f.input :pension
      f.input :title
      f.input :img, :as => :file
    end
    f.buttons
  end
end
