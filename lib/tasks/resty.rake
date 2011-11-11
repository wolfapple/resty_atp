# -*- encoding : utf-8 -*-
namespace :resty do
  desc 'task1'
  task :task1 => :environment do
    Pension.all.each do |pension|
      pension.update_attribute :address02, 'task1' if pension.addr.split(' ').last.scan(/\d/).count == 0
    end
  end
  
  desc 'task2'
  task :task2 => :environment do
    Pension.all.each do |pension|
      pension.update_attribute :address02, 'task2' if pension.address02 != 'task1' and pension.thumbnail.blank?
    end
  end
  
  desc 'social commerce'
  task :get_coupons => :environment do
    Coupon.get_today_deals
  end
  
  desc 'update like count'
  task :get_like_count => :environment do
    require 'open-uri'
    Pension.all.each do |pension|
      doc = Nokogiri::XML(open("https://api.facebook.com/method/fql.query?query=select%20total_count%20from%20link_stat%20where%20url=%22http://www.resty.co.kr/pensions/#{pension.id}%22"))
      pension.update_attribute :like_count, doc.css('total_count').inner_text.to_i
    end
  end
  
  desc 'add area_id to pension'
  task :area_match => :environment do
    Pension.where("substr(addr, 1, 2) = '경기'").update_all(:area_id => Area.find_by_title('경기도').id)
    Pension.where("substr(addr, 1, 2) = '강원'").update_all(:area_id => Area.find_by_title('강원도').id)
    Pension.where("substr(addr, 1, 2) = '충남'").update_all(:area_id => Area.find_by_title('충청남도').id)
    Pension.where("substr(addr, 1, 2) = '충북'").update_all(:area_id => Area.find_by_title('충청북도').id)
    Pension.where("substr(addr, 1, 2) = '경남'").update_all(:area_id => Area.find_by_title('경상남도').id)
    Pension.where("substr(addr, 1, 2) = '경북'").update_all(:area_id => Area.find_by_title('경상북도').id)
    Pension.where("substr(addr, 1, 2) = '전남'").update_all(:area_id => Area.find_by_title('전라남도').id)
    Pension.where("substr(addr, 1, 2) = '전북'").update_all(:area_id => Area.find_by_title('전라북도').id)
    Pension.where("substr(addr, 1, 2) = '제주'").update_all(:area_id => Area.find_by_title('제주도').id)
    Pension.where("substr(addr, 1, 2) in ('인천', '대구', '울산', '서울', '부산', '대전', '광주')").update_all(:area_id => Area.find_by_title('인천/기타').id)
    SubArea.all.each do |sub_area|
      if sub_area.title.index('(')
        like = sub_area.title[0...sub_area.title.index('(')]
        Pension.where(:area_id => sub_area.area.id).where("addr like '%#{like}%'").update_all :sub_area_id => sub_area.id
      else
        Pension.where(:area_id => sub_area.area.id).where("addr like '%#{sub_area.title}%'").update_all :sub_area_id => sub_area.id
      end
    end
    Pension.where(:area_id => 0).where('sub_area_id > 0').each do |pension|
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
  
  task :visitkorea => :environment do
    puts "VISITKOREA"
    pbar = ProgressBar.new("visitkorea", Pension.all.count)
    Pension.all.each do |pension|
      data = pension.pension_data.where(:crawlertype => 'VISITKOREA').first
      if data
        pension.update_attributes(data.attributes)
      end
      pbar.inc
    end
    pbar.finish
  end
  
  task :huepension => :environment do
    puts "HUEPENSION"
    pbar = ProgressBar.new("huepension", Pension.all.count)
    Pension.all.each do |pension|
      data = pension.pension_data.where(:crawlertype => 'HUEPENSION').first
      if data
        hash = data.attributes
        data.attribute_names.each do |attr|
          hash.delete(attr) if pension.attribute_present?(attr)
        end
        pension.update_attributes(hash)
        facilities01 = pension.facilities01.split(',') + data.facilities01.split(',')
        facilities01 = facilities01.uniq.collect {|x| x.strip}
        facilities02 = pension.facilities02.split(',') + data.facilities02.split(',')
        facilities02 = facilities02.uniq.collect {|x| x.strip}
        hash = {'facilities01' => facilities01.join(','), 'facilities02' => facilities02.join(',')}
        pension.update_attributes(hash)
      end
      pbar.inc
    end
    pbar.finish
  end
  
  task :naver => :environment do
    puts "naver"
    pbar = ProgressBar.new("naver", Pension.all.count)
    Pension.all.each do |pension|
      data = pension.pension_data.where(:crawlertype => 'NAVER').first
      if data
        hash = data.attributes
        data.attribute_names.each do |attr|
          hash.delete(attr) if pension.attribute_present?(attr)
        end
        pension.update_attributes(hash)
        hash = {'name' => data.name, 'url' => data.url, 'summary_naver' => data.summary, 'thumbnail_naver' => data.thumbnail}
        pension.update_attributes(hash)
      end
      pbar.inc
    end
    pbar.finish
  end
  
  task :daum => :environment do
    puts "daum"
    pbar = ProgressBar.new("daum", Pension.all.count)
    Pension.all.each do |pension|
      data = pension.pension_data.where(:crawlertype => 'DAUM').first
      if data
        hash = data.attributes
        data.attribute_names.each do |attr|
          hash.delete(attr) if pension.attribute_present?(attr)
        end
        pension.update_attributes(hash)
        hash = {'summary_daum' => data.summary, 'thumbnail_daum' => data.thumbnail}
        pension.update_attributes(hash)
      end
      pbar.inc
    end
    pbar.finish
  end
  
  task :insert_rooms => :environment do
    puts "insert rooms..."
    visitkoreas = PensionChamber.joins(:pension_data).where("pensiondata.crawlertype = 'VISITKOREA'")
    huepensions = PensionChamber.joins(:pension_data).where("pensiondata.crawlertype = 'HUEPENSION'")
    pbar = ProgressBar.new("room", visitkoreas.size + huepensions.size)
    visitkoreas.each do |room|
      Room.create(room.attributes)
      pbar.inc
    end
    huepensions.each do |room|
      pension_data = PensionData.where(:pensionsetid => room.pension_data.pensionsetid).where(:crawlertype => 'VISITKOREA').first
      if pension_data
        data = pension_data.rooms.find_by_pensionsetid_and_name room.pensionsetid, room.name
        if data
          hash = room.attributes
          room.attribute_names.each do |attr|
            hash.delete(attr) if data.attribute_present?(attr)
          end
          data.update_attributes(hash)
        end
      else
        Room.create(room.attributes)
      end
      pbar.inc
    end
    pbar.finish
  end
  
  task :update_pension_id => :environment do
    puts "pension_id update"
    pbar = ProgressBar.new("price", Room.count)
    Room.all.each do |room|
      pension = Pension.find_by_pensionsetid room.pensionsetid
      room.update_attribute :pension_id, pension.id if pension
      pbar.inc
    end
    pbar.finish
  end
  
  task :get_price => :environment do
    puts "get room price"
    pbar = ProgressBar.new("price", Room.count)
    Room.where("pension_id > 0").each do |room|
      price = room.price.gsub(',', '')
      arr = price.scan(/[\d]+/).collect {|x| x.to_i}.sort
      min_price = arr.first ? arr.first : 0
      max_price = arr.last ? arr.last : 0
      room.pension.update_attribute :min_price, min_price if room.pension.min_price == 0 or room.pension.min_price > min_price
      room.pension.update_attribute :max_price, max_price if room.pension.max_price < max_price
      pbar.inc
    end
    pbar.finish
  end
  
  task :update_ranking => :environment do
    puts "ranking..."
    pbar = ProgressBar.new("ranking", Pension.count)
    Pension.update_all :ranking => 0
    Pension.all.each do |pension|
      pension.increment! :ranking if pension.themes.count > 0
      if pension.facilities
        pension.increment! :ranking if pension.facilities.index('수영장')
        pension.increment! :ranking if pension.facilities.index('스파/월풀')
        pension.increment! :ranking if pension.facilities.index('카페')
        pension.increment! :ranking if pension.facilities.index('스파/월풀')
      end
      pension.increment! :ranking, 3 if pension.must_visit
      pension.increment! :ranking if pension.min_price > 0
      pension.increment! :ranking, pension.foreignlanguage.to_i if [1, 3, 5, -3, -5].include? pension.foreignlanguage.to_i
      pension.decrement! :ranking if pension.url and (pension.url.index('blog') or pension.url.index('cafe') or pension.url.index('visitkorea') or pension.url.index('huepension') or pension.url.index('kbs1'))
      pension.decrement! :ranking if pension.mobile.blank?
      pension.increment! :ranking, 5 unless pension.thumbnail.blank?
      pbar.inc
    end
    pbar.finish
  end
end