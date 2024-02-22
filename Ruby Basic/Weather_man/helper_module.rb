module Helper
  def year_info(year, city, path)
    data = data_seperator(year, city, path)
    values = {:max_temp => data[:high_temp].max, :min_temp => data[:low_temp].min, :max_humid => data[:humidity].max }
    dates = {:max_temp_date => data[:date][data[:high_temp].index(values[:max_temp])],
            :min_temp_date => data[:date][data[:low_temp].index(values[:min_temp])],
            :max_humid_date => data[:date][data[:humidity].index(values[:max_humid])] }

    system "clear"
    puts "Highest: #{values[:max_temp]}C on " + date(dates[:max_temp_date])
    puts "Lowest: #{values[:min_temp]}C on " + date(dates[:min_temp_date])
    puts "Humid: #{values[:max_humid]}% on " + date(dates[:max_humid_date])
  end

  def data_seperator(year, city, path)
    values = {:high_temp => [], :low_temp => [], :humidity => [], :date => []}
    12.times do |x|
      month = Date::MONTHNAMES[x+1][0..2]
      file_name = path + "/" + city + "_" + year + "_" + month + ".txt"
      if File.file?(file_name)
        lines = File.readlines(file_name)
        lines.each_with_index do |line,index|
          next if index == 0
          data = line.split(",")
          values[:high_temp].push(data[1].to_i)
          values[:low_temp]<<data[3].to_i
          values[:humidity]<<data[8].to_i
          values[:date]<<data[0]
        end
      end
    end
    values
  end

  def temp_bar_creator(value, str)
    bar = ""
    value.times do |i|
      bar += str
    end
    bar
  end

  def daily_info(year, month, city, path)
    system "clear"
    puts "#{month} #{year}"
    file_name = path + "/" + city + "_" + year + "_" + month + ".txt"
    lines = File.readlines(file_name)
    lines.each_with_index do |line,index|
      next if index == 0
      data = line.split(",")
      high_temp = data[1].to_i
      low_temp = data[3].to_i
      day = data[0].split('-').last

      print "#{day} #{temp_bar_creator(low_temp, "+").blue}#{temp_bar_creator(high_temp, "+").red} #{low_temp}C - #{high_temp}C\n"
    end
  end

  def month_info(year, month, city, path)
    values = {:day_count => 0, :avg_high => 0, :avg_low => 0, :avg_humidity => 0}
    file_name = path + "/" + city + "_" + year + "_" + month + ".txt"
    lines = File.readlines(file_name)
    lines.each_with_index do |line,index|
      next if index == 0
      data = line.split(",")
      values[:avg_high] += data[1].to_i
      values[:avg_low] += data[3].to_i
      values[:avg_humidity] += data[8].to_i
    end
    values[:day_count] = lines.length - 1

    system "clear"
    puts "Highest Average: #{values[:avg_high]/values[:day_count]}C"
    puts "Lowest Average: #{values[:avg_low]/values[:day_count]}C"
    puts "Average Humidity: #{values[:avg_humidity]/values[:day_count]}%"
  end

  def date(date)
    temp = date.split('-')
    month = Date::MONTHNAMES[temp[1].to_i]
    str = month + " " + temp.last.to_s
    str
  end

  def get_month(time)
    month = Date::MONTHNAMES[time.split("/")[1].to_i][0..2]
    month
  end
end
