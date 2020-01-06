class SnowReport::CLI

  def start
    # Will eventually hold the entire program loop
    welcome
  end

  def welcome
    puts "* * * *   * * * *"
    puts "*         *     *"
    puts "* * * *   * * * *"
    puts "      *   *   *"
    puts "* * * *   *     *"
    puts "WELCOME TO SNOW REPORT! (version #{SnowReport::VERSION})"
    puts "  A place to find the top ski resorts for all you ski and snowboard fans."
    puts "  Mountains are listed in order of most snow this current season."
    puts "  Ride Responsibly!"
    puts "* * *   * * *   * * *   * * *   * * *   * * *   * * *   * * *   * * *   * * *"
    puts " * *     * *     * *     * *     * *     * *     * *     * *     * *     * *"
  end

  def instruction

  end

end
