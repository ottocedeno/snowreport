require 'open-uri'
require "nokogiri"

#Scraper Class is responsisble for scraping data to be used for Mountain instantiation
class SnowReport::Scraper

  #CLASS METHODS:

  #Responesible for scraping the homepage of opensnow.com:
  def self.download_opensnow_index
    index_page = Nokogiri::HTML(open("https://opensnow.com/"))
    top_mountains = index_page.css("div.forecast-box div.recommended-resorts div.resort")

    mountains_array = []

    #Iterate through each mountain element, assign it's data into a hash k/v pair
    top_mountains.each do |mountain|
      mountain_info = {}

      mountain_info[:name] = mountain.css("div.name").text.strip
      mountain_info[:five_day_snowfall] = mountain.css("div.snowfall").text
      mountain_info[:url] = "https://opensnow.com" +  mountain.css("div.name a").attribute("href").value

      #Shovel mountain hash data into the mountains array:
      mountains_array << mountain_info
    end
    #Returns an array with mountain data in hashes:
    mountains_array
  end

  #Responsible for scraping an individual mountain's page on opensnow.com:
  def self.individual_mountain_data(mountain_url)
    mountain_page = Nokogiri::HTML(open(mountain_url))

    #First Section: Scrapes data that is found on all mountain pages:
    region = mountain_page.css("div.single-page-header div.location-info h2.subtitle").text
    tomorrow = mountain_page.css("div#forecast-block div.data-container").first.css("div.highsnow").first.text

    #Section Section: Scrapes data IF the mountain page contains additional terrain info:
    data_section_headers = mountain_page.css("div#report-data h3")
    terrain_header = data_section_headers.detect {|header| header.text == "Terrain"}
    if terrain_header
      terrain_data = terrain_header.next_element.css("div.data-cell")
      trails = terrain_data[1].text.strip
      lifts = terrain_data[2].text.strip
      base = terrain_data[3].text.strip
      #Addtionally: Not all mountain pages show conditions.  This checks to see data exists before scraping it:
      if terrain_data.size == 5
        conditions = terrain_data[4].text.strip
      end
    else
      trails, lifts, base, conditions = nil
    end

    #Loads and returns a hash containing all mountain data:
    mountain_hash = {
      region: region,
      tomorrows_snowfall: tomorrow,
      trails_open: trails,
      lifts_open: lifts,
      base_depth: base,
      conditions: conditions
    }
  end
  
end
