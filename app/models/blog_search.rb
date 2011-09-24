class BlogSearch
  attr_reader :results
  
  DAUM_KEY = "6ec77440b494f3985c75f386744a0c914d6a5422"
  NAVER_KEY = "c62d07d4a31a2879995b51ac4f0af84f"
  
  def initialize(query, total)
    url = "http://apis.daum.net/search/blog?apikey=#{BlogSearch::DAUM_KEY}&q=#{URI.escape(query)}&result=#{total}&page=1&sort=accu"
    require 'open-uri'
    doc = Nokogiri::XML(open(url))
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