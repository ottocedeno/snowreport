require 'open-uri'
require "nokogiri"

class SnowReport::Scraper

  def self.download_opensnow_index
    index_page = Nokogiri::HTML(open("https://opensnow.com/"))
    top_mountains = index_page.css("div.forecast-box div.recommended-resorts div.resort")
    mountains_array = []
    top_mountains.each do |mountain|
      mountain_info = {}
      mountain_info[:name] = mountain.css("div.name").text
      mountain_info[:five_day_snowfall] = mountain.css("div.snowfall").text.gsub("\"","")
      #load hash
      mountains_array << mountain_info
    end
    mountains_array
  end

end
