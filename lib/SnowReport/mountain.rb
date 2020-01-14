require 'colorize'

class SnowReport::Mountain
  attr_accessor :name, :snow_depth, :mountain_url, :region, :current_temp, :last_snowfall, :trails_open, :lifts_open

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

end


#for testing...
mam = SnowReport::Mountain.new
