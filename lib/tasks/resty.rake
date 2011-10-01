# -*- encoding : utf-8 -*-
namespace :resty do  
  desc 'add area_id to pension'
  task :area_match => :environment do
    Area.all.each do |area|
      if area.title.length == 4
        Pension.where("addr like ? or addr like ?", "%#{area.title}%", "%#{area.title[0]+area.title[2]}%").each do |pension|
          pension.update_attributes({:area_id => area.id})
        end
      else
        Pension.where("addr like ? or addr like ?", "%#{area.title}%", "%#{area.title.sub('도', '')}%").each do |pension|
          pension.update_attributes({:area_id => area.id})
        end
      end
    end
    SubArea.all.each do |sub_area|
      if sub_area.title.index('(')
        Pension.where("addr like ?", "%#{sub_area.title[0...sub_area.title.index('(')]}%").each do |pension|
          pension.update_attributes({:sub_area_id => sub_area.id})
        end
      elsif sub_area.title.rindex('도')
        Pension.where("addr like ?", "%#{sub_area.title[0...sub_area.title.rindex('도')]}%").each do |pension|
          pension.update_attributes({:sub_area_id => sub_area.id})
        end
      else
        Pension.where("addr like ?", "%#{sub_area.title}%").each do |pension|
          pension.update_attributes({:sub_area_id => sub_area.id})
        end
      end
    end
    Pension.where(:area_id => nil).where('sub_area_id is not null').each do |pension|
      pension.update_attributes({:area_id => pension.sub_area.area.id})
    end
    Area.update_all :pensions_count => 0
    SubArea.update_all :pensions_count => 0
    Area.all.each do |area|
      area.update_attributes({:pensions_count => area.pensions.count})
    end
    SubArea.all.each do |sub_area|
      sub_area.update_attributes({:pensions_count => sub_area.pensions.count})
    end
  end
  
  desc 'update pensions_count'
  task :update_pensions_count => :environment do
    Area.update_all :pensions_count => 0
    SubArea.update_all :pensions_count => 0
    Area.all.each do |area|
      area.update_attributes({:pensions_count => area.pensions.count})
    end
    SubArea.all.each do |sub_area|
      sub_area.update_attributes({:pensions_count => sub_area.pensions.count})
    end
  end
end