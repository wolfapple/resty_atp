# -*- encoding : utf-8 -*-
class PensionImage
  attr_reader :results
  
  KEY = "6ec77440b494f3985c75f386744a0c914d6a5422"
  
  def initialize(query, total, cache_key)
    begin
      cache = "#{Rails.root}/tmp/cache/pension_image/#{cache_key}.xml"
      raise if (Time.new - File.mtime(cache)) > 60 * 60 * 24
      doc = Nokogiri::XML(open(cache))
    rescue
      url = "http://apis.daum.net/search/image?apikey=#{PensionImage::KEY}&q=#{URI.escape(query)}&result=#{total}&output=xml"
      require 'open-uri'
      doc = Nokogiri::XML(open(url))
      if doc.xpath('apierror').blank?
        cache = File.new("#{Rails.root}/tmp/cache/pension_image/#{cache_key}.xml", "w")
        cache.write(doc.to_xml)
        cache.close
      end
    end
    @results = doc.xpath('//item').map do |i|
      PensionImageItem.new(i.xpath('link').inner_text, i.xpath('thumbnail').inner_text)
    end
  end
end

class PensionImageItem
  attr_reader :link, :thumbnail
  
  def initialize(link, thumbnail)
    @link = link
    @thumbnail = thumbnail
  end
end
