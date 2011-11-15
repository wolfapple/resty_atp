# -*- encoding : utf-8 -*-
class BlogSearch
  attr_reader :results
  
  KEY = "c62d07d4a31a2879995b51ac4f0af84f"
  
  def initialize(query, total, cache_key)
    begin
      cache = "#{Rails.root}/tmp/cache/blog_xml/#{cache_key}.xml"
      raise if (Time.new - File.mtime(cache)) > 60 * 60 * 24
      doc = Nokogiri::XML(open(cache))
    rescue
      url = "http://openapi.naver.com/search?key=#{BlogSearch::KEY}&query=#{URI.escape(query)}&display=#{total}&start=1&target=blog&sort=sim"
      require 'open-uri'
      doc = Nokogiri::XML(open(url))
      if doc.xpath('error').blank?
        cache = File.new("#{Rails.root}/tmp/cache/blog_xml/#{cache_key}.xml", "w")
        cache.write(doc.to_xml)
        cache.close
      end
    end
    @results = doc.xpath('//item').map do |i|
      BlogItem.new(i.xpath('title').inner_text, i.xpath('link').inner_text, i.xpath('description').inner_text)
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
