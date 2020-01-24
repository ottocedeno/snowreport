require 'colorize'

#Mountain Class is responsible for creating instances of mountains and storing thier respective data.
class SnowReport::Mountain

  #List of all Reader/Writer methods needed for Mountain objects:
  attr_accessor :name, :five_day_snowfall, :url, :region, :tomorrows_snowfall, :conditions, :base_depth, :trails_open, :lifts_open

  #Responsible for storing all Mountain instances:
  @@all = []

  #INSTANCE METHODS:

  #Note: All objects will save to the class variable @@all when created
  def initialize
    save
  end

  #Responsible for saving an instance of a Mountain into it's @@all variable:
  def save
    self.class.all << self
  end

  #Responsible for adding additional data from the individual Mountain's URL page:
  def add_mountain_data
    SnowReport::Scraper.individual_mountain_data(self.url).each do |key, value|
      self.send("#{key}=", value)
    end
  end

  #Responsible for printing user a friendly list of an individual Mountain's data
  def print_mountain_info
    puts "\n#{self.name}".upcase.colorize(:blue).bold
    puts "Located in #{self.region}".upcase if self.region
    puts "5 Day Snowfall: " + "#{self.five_day_snowfall}".colorize(:red) if self.five_day_snowfall
    puts "Tomorrow's Snow Fall: " + "#{self.tomorrows_snowfall}".colorize(:red) if self.tomorrows_snowfall
    puts "Conditions: " + "#{self.conditions}".colorize(:red) if self.conditions
    puts "Base Depth: " + "#{self.base_depth}".colorize(:red) if self.base_depth
    puts "Trails Open: " + "#{self.trails_open}".colorize(:red) if self.trails_open
    puts "Lifts Open: " + "#{self.lifts_open}\n".colorize(:red) if self.lifts_open
  end

  #CLASS METHODS:

  #Returns an array of all Mountain objects:
  def self.all
    @@all
  end

  #Responsible for clearing the @@all array of Mountain instances:
  def self.reset
    self.all.clear
  end

  #Responsible for creating Mountain objects from an array of mountains
  #Note: Each individual mountain's data will be contained in a hash
  def self.new_from_mountains_array(mountains)
    mountains.each do |mountain_hash|
      new_mountain = SnowReport::Mountain.new
      mountain_hash.each do |key, value|
        new_mountain.send("#{key}=", value)
      end
    end
  end

  #Searches @@all Mountains via a Mountain object's name.  Returns Mountain object if TRUE:
  def self.find_by_name(mountain_name)
    self.all.find {|mountain| mountain.name.downcase == mountain_name}
  end

  #Returns an array of all Mountain objects' name value only:
  def self.list_of_names
    self.all.map {|mountain| mountain.name.downcase}
  end

  #Responsible for updating all Mountains with data from their respective URL page:
  def self.update_all_mountains
    all.each do |mountain|
      mountain.add_mountain_data
    end
  end

  #Responsible for printing a user friendly list of the top level data for each Mountain object:
  def self.print_top_mountains
    puts "\nHere are the top #{self.all.size} mountains by 5 day snowfall".upcase.colorize(:blue).bold
    self.all.each.with_index(1) do |mountain, index|
      puts "#{index}. #{mountain.name} - #{mountain.five_day_snowfall} inches"
    end
    puts ""
  end

end
