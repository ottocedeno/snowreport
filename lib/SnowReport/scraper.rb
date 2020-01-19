require 'open-uri'
require "nokogiri"

class SnowReport::Scraper

  def self.download_opensnow_index
    index_page = Nokogiri::HTML(open("https://opensnow.com/"))
    top_mountains = index_page.css("div.forecast-box div.recommended-resorts div.resort")

    mountains_array = []

    top_mountains.each do |mountain|
      mountain_info = {}

      mountain_info[:name] = mountain.css("div.name").text.strip
      mountain_info[:five_day_snowfall] = mountain.css("div.snowfall").text
      mountain_info[:url] = "https://opensnow.com" +  mountain.css("div.name a").attribute("href").value

      mountains_array << mountain_info
    end
    mountains_array
  end

  def self.individual_mountain_data(mountain_url)
    mountain_page = Nokogiri::HTML(open(mountain_url)) #sub in mountail_url
    region = mountain_page.css("div.single-page-header div.location-info h2.subtitle").text
    tomorrow = mountain_page.css("div#forecast-block div.data-container").first.css("div.highsnow").first.text

    data_section_headers = mountain_page.css("div#report-data h3")
    terrain_header = data_section_headers.detect {|header| header.text == "Terrain"}
    if terrain_header
      terrain_data = terrain_header.next_element.css("div.data-cell")
      trails = terrain_data[1].text.strip
      lifts = terrain_data[2].text.strip
      base = terrain_data[3].text.strip
      if terrain_data.size == 5
        conditions = terrain_data[4].text.strip
      end
    else
      trails, lifts, base, conditions = nil
    end


    # current_temp = mountain_page.css("div#report-data div.data-container")[1].css("div.data-cell").first.text.strip
    # trails = mountain_page.css("div#report-data div.data-container")[2].css("div.data-cell")[1].text.strip
    # lifts = mountain_page.css("div#report-data div.data-container")[2].css("div.data-cell")[2].text.strip
    # base = mountain_page.css("div#report-data div.data-container")[2].css("div.data-cell")[3].text.strip
    # conditions = mountain_page.css("div#report-data div.data-container")[2].css("div.data-cell")[4].text.strip
    mountain_hash = {
      region: region,
      tomorrows_snowfall: tomorrow,
      # current_temp:  current_temp,
      trails_open: trails,
      lifts_open: lifts,
      base_depth: base,
      conditions: conditions
    }
  end
end
