# -*- encoding : utf-8 -*-
class DaumBlog
  attr_reader :pages, :results
  
  KEY = "6ec77440b494f3985c75f386744a0c914d6a5422"
  
  def search(query, page=1, result=10)
    url = "http://apis.daum.net/search/blog?apikey=#{DaumBlog::KEY}&q=#{URI.escape(query)}&result=#{result}&page=#{page}&sort=accu"
    require 'open-uri'
    doc = Nokogiri::XML(open(url))
    total = doc.xpath('//pageCount').inner_text.to_i
    @pages = 1.upto(total).to_a
    @results = doc.xpath('//item').map do |i|
      BlogItem.new(i.xpath('title').inner_text, i.xpath('link').inner_text, i.xpath('description'))
    end
  end
end

class BlogItem
  attr_reader :title, :link, :desc
  
  def initialize(title, link, desc)
    @title = title
    @link = link
    @desc = desc
  end
end