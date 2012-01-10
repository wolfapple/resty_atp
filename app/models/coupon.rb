# -*- encoding : utf-8 -*-
class Coupon < ActiveRecord::Base
  belongs_to :pension
  
  scope :ing, where(:is_valid => true).where("end_at > now()")
  scope :main, where(:is_valid => true).where("end_at > now()").order('rand()').group('pension_id').limit(6)
  scope :invalid, where(:is_valid => false).where("end_at > now()")
  
  def self.get_today_deals
    coupons = []
    coupons += self.make_hash("http://ticketmonster.co.kr/rss/couponmoa.php", '티켓몬스터')
    coupons += self.make_hash("http://wemakeprice.com/wemakeplace/rss/couponmoa_rss.xml", '위메프')
    coupons += self.make_hash("http://coupang.com/?act=dispCoupangRss5", '쿠팡')
    coupons += self.make_hash("http://www.groupon.kr/app/Product/xml/couponmoa", '그루폰')
    coupons += self.make_hash("http://cuzzle.co.kr/rss/rss_couponmoa.php", '커즐')
    coupons += self.make_hash("http://coozle.co.kr/rss/rss_couponmoa.php", '쿠즐')
    coupons += self.make_hash("http://www.ddnayo.com/PageSocial/rss/olcoo.ashx", '떠나요닷컴')
    coupons += self.make_hash("http://www.socialmanager.co.kr/Xml/Output/coupen/couponmoa.ga", '쿠펜')
    coupons += self.make_hash("http://www.moapanda.com/xml/couponMoa.php", "모아판다")
    coupons += self.make_hash("http://toursns.com/couponmoa.php", "소셜커머스여행")
    coupons += self.make_hash("http://www.dealnow.co.kr/front.php/meta/couponmoa", "딜나우")
    coupons += self.make_hash("http://g-old.co.kr/rss/couponmoa.php", "지금샵")
    coupons += self.make_hash("http://hotelstory.com/rss/couponmoa.php", "호텔스토리")
    coupons.compact!
    self.pension_matching(coupons)
  end
  
  def self.make_hash(url, provider)
    require 'open-uri'
    begin
      doc = Nokogiri::XML(open(url))
    rescue
      return []
    end
    doc.xpath("//deal[contains(title, '펜션')]").map do |i|
      addr = i.css('shop_address').inner_text.strip
      phone = i.css('shop_tel').inner_text.strip
      shop_name = i.css('shop_name').inner_text.strip
      next if addr.blank? or phone.blank? or shop_name.blank?
      begin
        {
          :provider => provider.strip,
          :title => i.xpath('title').inner_text.strip,
          :image => i.css('image')[0].inner_text.strip,
          :link => i.xpath('url').inner_text.strip,
          :org_price => i.xpath('original').inner_text.to_i,
          :dis_price => i.xpath('price').inner_text.to_i,
          :disrate => i.xpath('discount').inner_text.to_i,
          :start_at => i.xpath('start_at').inner_text,
          :end_at => i.xpath('end_at').inner_text,
          :addr => addr,
          :phone => phone,
          :shop_name => shop_name
        }
      rescue
        next
      end
    end
  end
  
  def self.pension_matching(coupons)
    coupons.each do |coupon|
      c = find_by_link coupon[:link]
      if c
        coupon.delete :addr
        coupon.delete :phone
        coupon.delete :shop_name
        c.update_attributes(coupon)
      else
        title = coupon[:shop_name].split(' ').last.gsub('펜션', '').gsub('팬션', '').gsub(/\P{Word}/u, '')
        like = title[0..2].strip
        rlike = title[-3..-1] ? title[-3..-1] : title
        phone = coupon[:phone].gsub(/\D/, '')
        addr = coupon[:addr].partition(' ').last.gsub(/\P{Word}/u, '').gsub('번지', '')
        pension = Pension.unscoped.where("title like ? or title like ?", "%#{like}%", "%#{rlike}%").where("REPLACE(REPLACE(mobile, ' ', ''), '-', '') = ? or REPLACE(REPLACE(telephone01, ' ', ''), '-', '') = ? or REPLACE(REPLACE(telephone02, ' ', ''), '-', '') = ?", phone, phone, phone).first
        pension = Pension.unscoped.where("title like ? or title like ?", "%#{like}%", "%#{rlike}%").where("REPLACE(REPLACE(MID(addr, LOCATE(' ', addr), CHAR_LENGTH(addr)), ' ', ''), '-', '') = ?", addr).first if pension.nil?
        pension = Pension.unscoped.where("REPLACE(REPLACE(REPLACE(title, ' ', ''), '펜션', ''), '팬션', '') = ?", title).near(coupon[:addr], 5, {:units => :km, :order => :distance}).first if pension.nil?
        if pension.nil?
          pension = Pension.unscoped.where("title like ? or title like ?", "%#{like}%", "%#{rlike}%").near(coupon[:addr], 5, {:units => :km, :order => :distance}).first
          coupon[:is_valid] = false
        else
          coupon[:is_valid] = true
        end
        coupon.delete :addr
        coupon.delete :phone
        coupon.delete :shop_name
        coupon[:pension_id] = pension.id unless pension.nil?
        create(coupon)
      end
    end
  end
end
