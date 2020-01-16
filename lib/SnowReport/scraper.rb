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
      mountain_info[:url] = "https://opensnow.com" +  mountain.css("div.name a").attribute("href").value

      mountains_array << mountain_info
    end
    mountains_array
  end

  def self.individual_mountain_data #sub in mountail_url
    mountain_page = Nokogiri::HTML(open("https://opensnow.com/location/sugarbowl")) #sub in mountail_url
    region = mountain_page.css("div.single-page-header div.location-info h2.subtitle").text
    current_temp = mountain_page.css("div#report-data div.data-container")[1].css("div.data-cell").first.text.strip

    binding.pry
  end
end
