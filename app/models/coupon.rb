# -*- encoding : utf-8 -*-
class Coupon < ActiveRecord::Base
  belongs_to :pension
  
  scope :main, where(:is_valid => true).where("end_at > now()").order('end_at').limit(6)
  scope :invalid, where(:is_valid => false)
  
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
    self.pension_matching(coupons)
  end
  
  def self.make_hash(url, provider)
    require 'open-uri'
    doc = Nokogiri::XML(open(url))
    doc.xpath("//deal[contains(title, '펜션')]").map do |i|
      {
        :provider => provider,
        :title => i.xpath('title').inner_text,
        :image => i.css('image')[0].inner_text,
        :link => i.xpath('url').inner_text,
        :org_price => i.xpath('original').inner_text.to_i,
        :dis_price => i.xpath('price').inner_text.to_i,
        :disrate => i.xpath('discount').inner_text.to_i,
        :start_at => i.xpath('start_at').inner_text,
        :end_at => i.xpath('end_at').inner_text,
        :addr => i.css('shop_address').inner_text,
        :phone => i.css('shop_tel').inner_text
      }
    end
  end
  
  def self.pension_matching(coupons)
    coupons.each do |coupon|
      pension = Pension.where('mobile = ? or telephone01 = ? or telephone02 = ?', coupon[:phone], coupon[:phone], coupon[:phone]).first
      pension = Pension.where("replace(replace(addr, ' ', ''), '번지', '') = ?", coupon[:addr].gsub(' ', '').gsub('번지', '')).first if pension.nil?
      pension = Pension.where("replace(replace(title, ' ', ''), '펜션', '') = ?", coupon[:title].gsub(' ', '').gsub('펜션', '')).near(coupon[:addr], 1, {:units => :km, :order => :distance, :limit => 1}).first if pension.nil?
      if pension.nil?
        pension = Pension.unscoped.near(coupon[:addr], 1, {:units => :km, :order => :distance, :limit => 1}).first
        coupon[:is_valid] = false
      else
        coupon[:is_valid] = true
      end
      coupon.delete :addr
      coupon.delete :phone
      if pension.nil?
        self.create(coupon)
      else
        c = self.find_or_create_by_pension_id pension.id
        c.update_attributes(coupon)
      end
    end
  end
end
