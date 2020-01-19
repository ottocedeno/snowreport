require 'colorize'

class SnowReport::Mountain
  attr_accessor :name, :five_day_snowfall, :url, :region, :tomorrows_snowfall, :trails_open, :lifts_open, :base_depth, :conditions
  @@all = []

  def initialize
    @has_extra_data = false
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
    mountain_data = SnowReport::Scraper.individual_mountain_data(self.url)
    mountain_data.each do |key, value|
      self.send("#{key}=", value)
    end
    self
  end

  def self.update_all_mountains
    all.each do |mountain|
      mountain.add_mountain_data
    end
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
    puts "Located in #{self.region}".upcase if self.region
    puts "5 Day Snowfall: " + "#{self.five_day_snowfall}".colorize(:red) if self.five_day_snowfall
    puts "Tomorrow's Snow Fall: " + "#{self.tomorrows_snowfall}".colorize(:red) if self.tomorrows_snowfall
    puts "Conditions: " + "#{self.conditions}".colorize(:red) if self.conditions
    puts "Base Depth: " + "#{self.base_depth}".colorize(:red) if self.base_depth
    puts "Trails Open: " + "#{self.trails_open}".colorize(:red) if self.trails_open
    puts "Lifts Open: " + "#{self.lifts_open}".colorize(:red) if self.lifts_open
    puts ""
  end

end
