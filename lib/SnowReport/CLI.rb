require 'colorize'

class SnowReport::CLI

  def start
    welcome
    instructions
    decision_loop
  end

  def welcome
    puts ""
    puts "* * * *   * * * *".colorize(:light_white)
    puts "*         *     *".colorize(:light_white)
    puts "* * * *   * * * *".colorize(:light_white)
    puts "      *   *   *".colorize(:light_white)
    puts "* * * *   *     *".colorize(:light_white)
    puts ""
    puts "WELCOME TO SNOW REPORT! (version #{SnowReport::VERSION})".colorize(:blue).bold
    puts "  A place to find the top ski resorts for all you ski and snowboard fans."
    puts "  Mountains are listed in order of most snow this current season."
    puts "  Ride Responsibly!"
    puts ""
    puts "* * *    * *    * * *    * *    * * *    * *    * * *    * *    * * *    * * ".colorize(:light_white)
    puts " * *    * * *    * *    * * *    * *    * * *    * *    * * *    * *    * * *".colorize(:light_white)

  end

  def instructions
    puts ""
    puts "INSTRUCTIONS".colorize(:blue).bold
    puts "Snow Report accepts the following commands:"
    puts "  TOP TEN:  ".colorize(:red) + "Shows a list of the top mountains by snowfall..."
    puts "    To select a specific mountain from the list, type it's " + "NAME".colorize(:red)
    puts "  HELP:  ".colorize(:red) + "Will repeat this message at anytime"
    puts "  EXIT:  ".colorize(:red) + "Will exit the application"
    puts ""
  end

  def prompt
    print "What would you like to do?  "
    gets.strip.downcase
  end

  def input_error
    puts ""
    puts "Wipe Out! That command was not found.".upcase.colorize(:red).bold
    puts "Try HELP if you're stuck.".colorize(:red)
    puts ""
  end

  def decision_loop
    user_input = nil

    while user_input != "exit"
      user_input = prompt

      if user_input == "top ten"
        SnowReport::Mountain.print_top_mountains

      elsif SnowReport::Mountain.list_of_names.include?(user_input)
        mountain = SnowReport::Mountain.find_by_name(user_input)
        mountain.add_mountain_data  if mountain.has_extra_data == false
        mountain.print_mountain_info

      elsif user_input == "help"
        instructions

      elsif user_input == "exit"
        puts ""
        puts "Pack up the board call it a day...".upcase.colorize(:blue).bold
        puts "Until next time!"
        puts ""
        SnowReport::Mountain.reset

      else
        input_error
      end
    end
  end

end
