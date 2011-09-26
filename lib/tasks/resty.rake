# -*- encoding : utf-8 -*-
namespace :resty do
  desc 'Insert into data from pensiondata to pensions'
  task :insert_pensions => :environment do
    PensionData.all.each do |pension|
      Pension.create({
        :title => pension.name,
        :url => pension.url,
        :addr => pension.address01,
        :mobile => pension.mobile,
        :phone => pension.telephone01,
        :phone2 => pension.telephone02,
        :email => pension.email,
        :manager => pension.manager,
        :rating => (pension.evaluation[5..6].to_i if pension.evaluation),
        :summary => pension.summary,
        :rooms_count => pension.roomcount,
        :room_structure => pension.roomstructure,
        :season_info => pension.seasoninfo,
        :checkin => pension.checkinout,
        :service_charge => pension.servicecharge,
        :tax_include => pension.includetax,
        :lat => pension.locationx,
        :lng => pension.locationy,
        :credit_card => pension.creditcard,
        :pet => pension.pet,
        :breakfast => pension.breakfast,
        :foreign_language => pension.foreignlanguage,
        :pickup => pension.pickupservice,
        :facilities => pension.facilities01,
        :facilities2 => pension.facilities02,
        :foodcourt => pension.foodcourt,
        :baby => pension.babycarriage
      })
    end
  end

  desc 'Insert into data from pensionchamber to room'
  task :insert_rooms => :environment do
    PensionChamber.all.each do |room|
      Room.create({
        :title => room.name,
        :type => room.type,
        :area => room.area,
        :price => room.price,
        :additional_price => room.priceadditional,
        :facilities => room.facilities01,
        :facilities2 => room.facilities02,
        :number => room.number,
        :desc => room.description01,
        :desc2 => room.description02,
        :season_info => room.seasoninfo,
        :image => room.imageurl
      })
    end
  end
  
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
  
  desc 'truncate rooms'
  task :reset_rooms => :environment do
    ActiveRecord::Base.connection.execute("TRUNCATE #{Room.table_name}")
  end
  
  desc 'truncate pensions'
  task :reset_pensions => :environment do
    ActiveRecord::Base.connection.execute("TRUNCATE #{Pension.table_name}")
  end
  
  task :all_reset => [:reset_rooms, :reset_pensions]
  task :insert_data => [:insert_pensions, :insert_rooms]
  task :insert_data_reset => [:all_reset, :insert_data]
end