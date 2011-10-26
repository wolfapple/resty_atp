# -*- encoding : utf-8 -*-
class Notice
  attr_reader :title, :link
  
  def initialize(title, link)
    @title = title
    @link = link
  end
  
  def self.recent
    url = "http://resty.tistory.com/rss/xml"
    require 'open-uri'
    doc = Nokogiri::XML(open(url))
    @results = doc.xpath('//item').map do |i|
      Notice.new(i.xpath('title').inner_text, i.xpath('link').inner_text)
    end
    @results = @results[0...4]
  end
end
