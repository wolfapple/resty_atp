# -*- encoding : utf-8 -*-
class Coupon < ActiveRecord::Base
  belongs_to :pension
  
  scope :main, where(:is_valid => true).where("end_at > now()").order('rand()').limit(6)
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
        :provider => provider.strip,
        :title => i.xpath('title').inner_text.strip,
        :image => i.css('image')[0].inner_text.strip,
        :link => i.xpath('url').inner_text.strip,
        :org_price => i.xpath('original').inner_text.to_i,
        :dis_price => i.xpath('price').inner_text.to_i,
        :disrate => i.xpath('discount').inner_text.to_i,
        :start_at => i.xpath('start_at').inner_text,
        :end_at => i.xpath('end_at').inner_text,
        :addr => i.css('shop_address').inner_text.strip,
        :phone => i.css('shop_tel').inner_text.strip,
        :shop_name => i.css('shop_name').inner_text.strip
      }
    end
  end
  
  def self.pension_matching(coupons)
    coupons.each do |coupon|
      title = coupon[:shop_name].gsub('펜션', '').gsub('팬션', '').gsub(' ', '').gsub('(', '').gsub(')', '')
      like = title[0..2].strip
      rlike = title[-3..-1] ? title[-3..-1] : title
      pension = Pension.unscoped.where("title like ? or title like ?", "%#{like}%", "%#{rlike}%").where('mobile = ? or telephone01 = ? or telephone02 = ?', coupon[:phone], coupon[:phone], coupon[:phone]).first
      pension = Pension.unscoped.where("title like ? or title like ?", "%#{like}%", "%#{rlike}%").where("replace(replace(addr, ' ', ''), '번지', '') = ?", coupon[:addr].gsub(' ', '').gsub('번지', '')).first if pension.nil?
      pension = Pension.unscoped.where("replace(replace(title, ' ', ''), '펜션', '') = ?", title).near(coupon[:addr], 5, {:units => :km, :order => :distance}).first if pension.nil?
      if pension.nil?
        pension = Pension.unscoped.where("title like ? or title like ?", "%#{like}%", "%#{rlike}%").near(coupon[:addr], 5, {:units => :km, :order => :distance}).first
        coupon[:is_valid] = false
      else
        coupon[:is_valid] = true
      end
      coupon.delete :addr
      coupon.delete :phone
      coupon.delete :shop_name
      if pension.nil?
        self.create(coupon)
      else
        c = self.find_or_create_by_pension_id_and_start_at_and_end_at pension.id, coupon[:start_at], coupon[:end_at]
        c.update_attributes(coupon) unless c.is_valid
      end
    end
  end
end
