# -*- encoding : utf-8 -*-
class NaverBlog
  attr_reader :title, :link, :desc
  
  KEY = "c62d07d4a31a2879995b51ac4f0af84f"
  
  def initialize(title, link, desc)
    @title = title
    @link = link
    @desc = desc
  end
  
  def self.search(query, start=1, display=10)
    url = "http://openapi.naver.com/search?key=#{self::KEY}&query=#{URI.escape(query)}&display=#{display}&start=#{start}&target=blog&sort=sim"
    require 'open-uri'
    doc = Nokogiri::XML(open(url))
    results = doc.xpath('//item').map do |i|
      NaverBlog.new(i.xpath('title').inner_text, i.xpath('link').inner_text, i.xpath('description'))
    end
  end
end
