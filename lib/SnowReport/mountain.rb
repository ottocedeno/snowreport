require 'colorize'

class SnowReport::Mountain
  attr_accessor :name, :snow_depth, :url, :region, :current_temp, :last_snowfall, :trails_open, :lifts_open

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

  def self.new_from_page_index(mountain_array)
    mountain_array.each do |mountain_hash|
      new_mountain = SnowReport::Mountain.new
      new_mountain.name = mountain_hash[:name]
      new_mountain.snow_depth = mountain_hash[:snow_depth]
      new_mountain.url = mountain_hash[:url]
    end
  end

  def self.print_top_mountains
    puts ""
    puts "Here are the top #{self.all.size} mountains".upcase.colorize(:blue)
    self.all.each.with_index(1) do |mountain, index|
      puts "#{index}. #{mountain.name} - #{mountain.snow_depth} inches"
    end
    puts ""
  end

end

test_array = [
  {name: "Whistler", snow_depth: 104, url: "www.example.com/whistler"},
  {name: "Mammouth", snow_depth: 99, url: "www.example.com/mammouth"}
]
