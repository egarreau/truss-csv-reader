require 'time'

module RowParser

  def self.call(row)
    begin
      row['Timestamp'] = timestamp(row['Timestamp'])
    rescue ArgumentError
      STDERR.puts 'Timestamp could not be parsed'
      return nil
    end
    row['ZIP'] = zipcode(row['ZIP'])
    row['FullName'] = name(row['FullName'])
    row['FooDuration'] = time_to_seconds(row['FooDuration'])
    row['BarDuration'] = time_to_seconds(row['BarDuration'])
    row['TotalDuration'] = row['FooDuration'] + row['BarDuration']
    return row
  end

  def self.timestamp(ts)
    time = Time.strptime(ts, '%m/%d/%y %l:%M:%S').getlocal('-08:00') + (2*3600)
    time = time.getlocal('-05:00')
    time.iso8601      
  end

  def self.zipcode(zip)
    if zip.length < 5
      zip.prepend('0')
    else
      zip
    end
  end

  def self.name(name)
    name.upcase
  end

  def self.time_to_seconds(duration)
    time_hash = {}
    time = duration.scan(/(\d+)/).flatten
    time_hash[:hour] = time[0].to_f * 3600
    time_hash[:min] = time[1].to_f * 60
    time_hash[:sec] = time[2].to_f
    time_hash[:milli] = time[3].to_f/1000
    time_hash.values.reduce(:+)
  end
end
