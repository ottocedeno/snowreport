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
    puts "  TOP MOUNTAINS:  Shows a list of the top mountains by snowfall..."
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
    puts ""
    puts "Wipe Out! That command was not found.".colorize(:red)
    puts "Try HELP if you're stuck.".colorize(:red)
    puts ""
  end

  def decision_loop
    user_input = nil

    while user_input != "exit"
      user_input = prompt

      # #test list for now...
      # fake_list = ["whistler", "mammouth"]

      if user_input == "top mountains"
        SnowReport::Mountain.print_top_mountains
      elsif SnowReport::Mountain.names_list.include?(user_input) #update this with the real list....
        puts "this works for now..."
      elsif user_input == "help"
        instructions
      elsif user_input == "exit"
        puts ""
        puts "Pack up the board and let's call it a day...Until next time!".colorize(:blue)
        SnowReport::Mountain.reset
      else
        input_error
      end
    end
  end

end
