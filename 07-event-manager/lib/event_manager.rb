require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'time'



def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def clean_phone_number(number)
  number = number.split('').filter {|num| Integer(num, exception: false).is_a?(Integer)}
  return '' if number.length < 10 || number.length > 11
  number.shift if number.length == 11 && number[0] == '1'
  return '' if number.length == 11
  number.join("")
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'
  begin 
    legislators = civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    )
    legislators.officials
  rescue
    'You can find your representatives elsewhere'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')
  filename = "output/thanks_#{id}.html"
  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

def most_popular_times(times)
  time_freq = Hash.new(0)
  times.sum {|t| time_freq[t.hour]+=1}
  time_freq.max_by {|k,v| v}
end

def most_popular_day (dates)
  days_of_the_week = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
  date_freq = Hash.new(0)
  dates.sum {|d| date_freq[d.wday]+=1}
  days_of_the_week[date_freq.max_by {|k, v| v}[0]]
end

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

puts 'Event manager Initialized!'

contents = CSV.open('event_attendees.csv', headers: true, header_converters: :symbol) if File.exist? "event_attendees.csv"
reg_times = []
reg_dates = []
contents.each_with_index do |row|
  id = row[0]

  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)

  
  reg_date = row[:regdate]
  reg_times.push(Time.parse(reg_date.split[1]))
  reg_date = reg_date.split[0]
  reg_date = Date.strptime(reg_date, "%m/%d/%y")
  reg_dates.push(reg_date)


  form_letter = erb_template.result(binding)
  save_thank_you_letter(id, form_letter)
  
  #puts "#{name} #{zipcode} #{legislator_string}"
end
