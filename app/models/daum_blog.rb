class DaumBlog
  attr_reader :title, :link, :desc
  
  KEY = "6ec77440b494f3985c75f386744a0c914d6a5422"
  
  def initialize(title, link, desc)
    @title = title
    @link = link
    @desc = desc
  end
  
  def self.search(query, page=1, result=10)
    url = "http://apis.daum.net/search/blog?apikey=#{self::KEY}&q=#{URI.escape(query)}&result=#{result}&page=#{page}&sort=accu"
    require 'open-uri'
    doc = Nokogiri::XML(open(url))
    results = doc.xpath('//item').map do |i|
      self.new(i.xpath('title').inner_text, i.xpath('link').inner_text, i.xpath('description'))
    end
  end
end