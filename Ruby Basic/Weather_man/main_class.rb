class Main
  include Helper

  def initialize
    puts "Loading...."
    sleep(2)
  end

  def start
    option = ARGV[0]
    time = ARGV[1]
    path = ARGV[2]

    year = time.split("/")[0]
    city = path.split("/").last
    if option == "-e"
      year_info(year, city, path)
    else
      month = get_month(time)
      if option == "-a"
        month_info(year, month, city, path)
      elsif option == "-c"
        daily_info(year, month, city, path)
      else
        puts "Invalid Arguments, Please try Again !!!!"
      end
    end
  end
end
