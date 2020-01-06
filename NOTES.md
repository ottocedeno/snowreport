IDEA
* Snow Report:
    * Dynamically lists the top mountains by snowfall.
        * Name and amount
        * 1. Whistler - 74"
    * Can select each mountain for more details:
        *  Mountain Name
        * Region
        * Temp?
        * Snow fall stats
            * Last 24
            * today
            * Tomorrow
        * Trails open
        * Lifts opens


CLI
* .start => contains the primary loop
    * #welcome => outputs a greeting to the user
    * #instructions => outputs the available commands to the user
    * #prompt => it prompts the user what it would like to do, and returns the users responds.
    * #exit => it calls Mountain.reset and puts a farewell message to the user

Mountain
* Attr_accessor list:
    * :mountain_name
    * :current_snow_depth
    * :mountain_url
    * :region
    * :current_temp
    * :snowfall_stats
    * :trails_open
    * :lifts_open
* .new_from_index(array_of mountains) => it instantiates a new mountain object for each item in the array_of_mountains array.  It assigns hash values to appropriate object attributes.
* #add_mountain_data => it uses the individual mountain scraper, and adds in additional info into an existing mountain instance
* .all => returns an array of all mountain objects
* .reset => resets the @@all array to an empty array
* .print_top_mountains => iterates over ALL the mountains and prints out the information in an easy to read format
* #print_mountain_info => prints a user friendly format of all the data collected for that particular mountain object

Scraper
* .top_mountain_data(index_page) => it scrapes a webpage that lists the top mountains and their current snow depths.  Returns an array containing hashes for each mountain.
    * Each mountain hash should be {:mountain_name, :current_snow_depth, :mountain_url}
* .individual_mountain_data(mountain_url) => it accepts a mountain URL and scrapes all additional data and updates the mountain hash
