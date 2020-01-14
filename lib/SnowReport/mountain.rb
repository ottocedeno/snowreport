require 'colorize'

class SnowReport::Mountain
  attr_accessor :name, :snow_depth, :mountain_url, :region, :current_temp, :last_snowfall, :trails_open, :lifts_open

  def initialize(name)
    @name = name
  end
end

mam = SnowReport::Mountain.new("Mammouth")