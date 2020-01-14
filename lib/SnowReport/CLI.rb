require 'colorize'

class SnowReport::CLI

  def start
    welcome
    instructions
    decision_loop
  end

  def welcome
    puts "* * * *   * * * *".colorize(:light_white)
    puts "*         *     *".colorize(:light_white)
    puts "* * * *   * * * *".colorize(:light_white)
    puts "      *   *   *".colorize(:light_white)
    puts "* * * *   *     *".colorize(:light_white)
    puts ""
    puts "WELCOME TO SNOW REPORT! (version #{SnowReport::VERSION})".colorize(:blue)
    puts "  A place to find the top ski resorts for all you ski and snowboard fans."
    puts "  Mountains are listed in order of most snow this current season."
    puts "  Ride Responsibly!"
    puts ""
    puts "* * *    * *    * * *    * *    * * *    * *    * * *    * *    * * *    * * ".colorize(:light_white)
    puts " * *    * * *    * *    * * *    * *    * * *    * *    * * *    * *    * * *".colorize(:light_white)

  end

  def instructions
    puts ""
    puts "INSTRUCTIONS".colorize(:blue)
    puts "Snow Report accepts the following commands:"
    puts "  TOP MOUNTAINS:  Shows a list of the top X mountains by snowfall..."
    puts "    To select a specific mountain from the list, type it's NAME"
    puts "  HELP:  Will repeat this message at anytime"
    puts "  EXIT:  Will exit the application"
    puts ""
  end

  def prompt
    print "What would you like to do?  "
    gets.strip.downcase
  end

  def input_error
    puts "Wipe Out! That command was not found.".colorize(:red)
    puts "Try HELP if you're stuck.".colorize(:red)
    puts ""
  end

  def decision_loop
    user_input = nil

    while user_input != "exit"
      user_input = prompt

      case user_input
      when "top mountains"
        #update this with a Mountain class method
        puts "Here are the top ten mountains".upcase.colorize(:blue)
        puts '1. Whistler - 103"'
        puts '2. Snowmass - 97"'
        puts '3. Mammouth - 85"'
        puts ""
      when "help"
        instructions
      when "exit"
        puts "Pack up the board and let's call it a day...Until next time!"
        exit(0)
      else
        input_error
      end
    end
  end

end
