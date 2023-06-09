require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'



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

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

puts 'Event manager Initialized!'

contents = CSV.open('event_attendees.csv', headers: true, header_converters: :symbol) if File.exist? "event_attendees.csv"

contents.each_with_index do |row|
  id = row[0]

  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)
  #save_thank_you_letter(id, form_letter)
  
  #puts "#{name} #{zipcode} #{legislator_string}"
end