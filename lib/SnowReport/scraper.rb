require 'open-uri'
require "nokogiri"

class SnowReport::Scraper

  def self.open_url(url)
    Nokogiri::HTML(open(url))
  end

  def self.opensnow_index
    index_page = self.open_url("https://opensnow.com/")
    top_resorts = index_page.css("div.forecast-box div.recommended-resorts div.resort")

    top_resorts.each do |resort|
      {
        name: resort.css("div.name").text,
        }
    end
    binding.pry
  end
end
