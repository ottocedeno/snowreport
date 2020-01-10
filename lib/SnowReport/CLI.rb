class SnowReport::CLI

  def start
    # Will eventually hold the entire program loop
    welcome
    instructions
    decision_loop
  end

  def welcome
    puts "* * * *   * * * *"
    puts "*         *     *"
    puts "* * * *   * * * *"
    puts "      *   *   *"
    puts "* * * *   *     *"
    puts ""
    puts "WELCOME TO SNOW REPORT! (version #{SnowReport::VERSION})"
    puts "  A place to find the top ski resorts for all you ski and snowboard fans."
    puts "  Mountains are listed in order of most snow this current season."
    puts "  Ride Responsibly!"
    puts ""
    puts "* * *    * *    * * *    * *    * * *    * *    * * *    * *    * * *    * * "
    puts " * *    * * *    * *    * * *    * *    * * *    * *    * * *    * *    * * *"

  end

  def instructions
    puts ""
    puts "INSTRUCTIONS"
    puts "Snow Report accepts the following commands:"
    puts "  TOP MOUNTAINS:  Shows a list of the top X mountains by snowfall..."
    puts "    To select a specific mountain from the list, type it's NAME"
    puts "  HELP:  Will repeat this message at anytime"
    puts "  EXIT:  Will exit the application"
    puts ""
  end

  def prompt
    print "What could you like to do?  "
    gets.strip.downcase
  end
  
  def decision_loop

  end

end
