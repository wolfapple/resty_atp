class NaverBlog
  require 'net/http'
  attr_reader :title, :link, :description
  key = "c62d07d4a31a2879995b51ac4f0af84f"
  url = "http://openapi.naver.com/search?key=test&query=&display=10&start=1&target=blog&sort=sim"
end