# -*- encoding : utf-8 -*-
class Notice
  attr_reader :title, :link
  
  def initialize(title, link)
    @title = title
    @link = link
  end
  
  def self.recent
    begin
      cache = "#{Rails.root}/tmp/cache/notice.xml"
      doc = Nokogiri::XML(open(cache))
    rescue
      url = "http://resty.tistory.com/rss/xml"
      require 'open-uri'
      doc = Nokogiri::XML(open(url))
      cache = File.new("#{Rails.root}/tmp/cache/notice.xml", "w")
      cache.write(doc.to_xml)
      cache.close
    end
    @results = doc.xpath('//item').map do |i|
      Notice.new(i.xpath('title').inner_text, i.xpath('link').inner_text)
    end
    @results = @results[0...4]
  end
end
