require 'colorize'

class SnowReport::CLI

  #Responsible for the high level application logic:
  def start
    welcome
    load_mountain_data
    instructions
    decision_loop
  end

  #Responsible for introduction to the user:
  def welcome
    puts ""
    puts "* * * *   * * * *".colorize(:light_white)
    puts "*         *     *".colorize(:light_white)
    puts "* * * *   * * * *".colorize(:light_white)
    puts "      *   *   *".colorize(:light_white)
    puts "* * * *   *     *".colorize(:light_white)
    puts ""
    puts "WELCOME TO SNOW REPORT! (version #{SnowReport::VERSION})".colorize(:blue).bold
    puts "A place to find the top ski resorts for all you winter sport fans."
    puts "Snow Report shows you which mountains are expected to get DUMPED on over the next few days."
    puts "You can even select mountains from the list to find out more info!"
    puts "Ride Responsibly!\n\n".upcase
  end

  #Responsible for calling appropriate Mountain object methods that loads mountain data into the application:
  def load_mountain_data
    puts "Loading Mountain Data...".upcase.colorize(:red).bold

    #This step is important if the user REFRESHES:
    SnowReport::Mountain.reset if SnowReport::Mountain.all.size > 0

    #Main step that loads in all mountain data from Scraper class methods:
    SnowReport::Mountain.new_from_mountains_array(SnowReport::Scraper.download_opensnow_index)
    SnowReport::Mountain.update_all_mountains

    puts "Success!\n".upcase.colorize(:blue).bold
  end

  #Responsible for educating the user on available commands:
  def instructions
    puts "INSTRUCTIONS".colorize(:blue).bold
    puts "Snow Report accepts the following commands:"
    puts "  TOP TEN:  ".colorize(:red) + "Will show you a list of which mountains are expecting the most snow in the coming days."
    puts "  Type a mountain's " + "NAME:  ".colorize(:red) + "Will show you more details on that specific mountain."
    puts "  REFRESH:  ".colorize(:red) + "Will update mountain data"
    puts "  HELP:  ".colorize(:red) + "Will repeat this message at anytime"
    puts "  EXIT:  ".colorize(:red) + "Will exit the application\n\n"
  end

  # Responsible for prompting user for input and returning it's value:
  def prompt
    print "What would you like to do?  "
    gets.strip.downcase
  end

  #Responsible for letting the user know of an invalid command:
  def input_error
    puts "Wipe Out! That command was not found.".upcase.colorize(:red).bold
    puts "Try HELP if you're stuck.\n".colorize(:red)
  end

  #Responsible for the main interactive application loop and returning the appropriate data depending on user input:
  def decision_loop
    user_input = nil

    while user_input != "exit"
      user_input = prompt

      if user_input == "top ten"
        SnowReport::Mountain.print_top_mountains

      elsif SnowReport::Mountain.list_of_names.include?(user_input)
        SnowReport::Mountain.find_by_name(user_input).print_mountain_info

      elsif user_input == "refresh"
        load_mountain_data

      elsif user_input == "help"
        instructions

      elsif user_input == "exit"
        SnowReport::Mountain.reset
        puts "\nPack it up and call it a day...".upcase.colorize(:blue).bold
        puts "Until next time, hang lose!\n"

      else
        input_error
      end
    end
  end

end
