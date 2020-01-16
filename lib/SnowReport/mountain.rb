require 'colorize'

class SnowReport::Mountain
  attr_accessor :name, :five_day_snowfall, :url, :region, :current_temp, :last_snowfall, :trails_open, :lifts_open

  @@all = []

  def initialize
    save
  end

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.reset
    self.all.clear
  end

  def self.find_by_name(mountain_name)
    self.all.find {|mountain| mountain.name.downcase == mountain_name}
  end

  def self.list_of_names
    self.all.map {|mountain| mountain.name.downcase}
  end

  def self.new_from_mountains_array(mountains)
    mountains.each do |mountain_hash|
      new_mountain = SnowReport::Mountain.new
      mountain_hash.each do |key, value|
        new_mountain.send("#{key}=", value)
      end
    end
  end

  def add_mountain_data
    #Eventually:  test_data = SnowReport::Scraper.scrape_mountain(self.url)
    test_data = {region: "Canada", current_temp: 34, last_snowfall: 0, trails_open: 65, lifts_open: 12}
    test_data.each do |key, value|
      self.send("#{key}=", value)
    end
    self
  end

  def self.print_top_mountains
    puts ""
    puts "Here are the top #{self.all.size} mountains by 5 day snowfall".upcase.colorize(:blue).bold
    self.all.each.with_index(1) do |mountain, index|
      puts "#{index}. #{mountain.name} - #{mountain.five_day_snowfall} inches"
    end
    puts ""
  end

  def print_mountain_info
    puts ""
    puts "#{self.name}".upcase.colorize(:blue).bold
    puts "Located in #{self.region}" if self.region
    puts "Current Temperature: " + "#{self.current_temp} degrees".colorize(:red) if self.current_temp
    puts "5 Day Snowfall: " + "#{self.five_day_snowfall} inches".colorize(:red) if self.five_day_snowfall
    puts "Last Snow Fall: " + "#{self.last_snowfall} inches".colorize(:red) if self.last_snowfall
    puts "Trails Open: " + "#{self.trails_open}".colorize(:red) if self.trails_open
    puts "Lifts Open: " + "#{self.lifts_open}".colorize(:red) if self.lifts_open
    puts ""
  end

end

test_array = [
  {name: "Whistler", snow_depth: 104, url: "www.example.com/whistler"},
  {name: "Mammouth", snow_depth: 99, url: "www.example.com/mammouth"}
]
