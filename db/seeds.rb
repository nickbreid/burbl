# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

require 'csv'

# seed the stops
csv_text = File.read(Rails.root.join('db', 'stops_data.csv'))
csv = CSV.parse(csv_text, headers: true, encoding: 'ISO-8859-1')

csv.each do |row|
  t = Stop.new
  t.miles_from_ga = row['miles_from_ga']
  t.to_next_point = row['to_next_point']
  t.name = row['name']
  t.town_access = row['town_access']
  t.elevation = row['elevation']
  t.miles_from_k = row['miles_from_k']
  t.save

  if t.valid?
    puts "#{t.miles_from_ga} - #{t.name} saved"
  else
    puts "#{t.miles_from_ga} - #{t.name} DID NOT SAVE"
  end

end

puts "There are now #{Stop.count} rows in the stop table"


# seed the resources
RESOURCES = ["bus", "campsites", "coin laundry", "doctor, medical", "fuel", "groceries, supplies", "short-term resupply", "hostel", "lodging", "meals, restaurants", "outfitter", "parking", "post office", "road access", "shelter", "shower", "train", "no potable water", "veterinarian", "water", "all"]

RESOURCES.each do |resource|
  t = Resource.new
  t.name = resource
  t.save

  if t.valid?
    puts "#{t.name} saved"
  else
    puts "#{t.name} DID NOT SAVE"
  end

end

puts "There are now #{Resource.count} rows in the resources table"

# turn shorthand Stopresources into long-form
def parse_stop_resource_shorthand(stop_resource, stop)
  t = Stopresource.new
  t.stop = stop
  t.stop_name = stop.name
  stop_resource = stop_resource.strip

  if stop_resource == "C"
    t.resource = Resource.find_by(name: "campsites")
    t.save
  elsif stop_resource == "w"
    t.resource = Resource.find_by(name: "water")
    t.save
  elsif stop_resource == "R"
    t.resource = Resource.find_by(name: "road access")
    t.save
  elsif stop_resource == "P"
    t.resource = Resource.find_by(name: "parking")
    t.save
  elsif stop_resource == "S"
    t.resource = Resource.find_by(name: "shelter")
    t.save
  elsif stop_resource == "PO"
    t.resource = Resource.find_by(name: "post office")
    t.save
  elsif stop_resource == "M"
    t.resource = Resource.find_by(name: "meals, restaurants")
    t.save
  elsif stop_resource == "G"
    t.resource = Resource.find_by(name: "groceries, supplies")
    t.save
  elsif stop_resource == "L"
    t.resource = Resource.find_by(name: "lodging")
    t.save
  elsif stop_resource == "B"
    t.resource = Resource.find_by(name: "bus")
    t.save
  elsif stop_resource == "cl"
    t.resource = Resource.find_by(name: "coin laundry")
    t.save
  elsif stop_resource == "g"
    t.resource = Resource.find_by(name: "short-term resupply")
    t.save
  elsif stop_resource == "D"
    t.resource = Resource.find_by(name: "doctor, medical")
    t.save
  elsif stop_resource == "V"
    t.resource = Resource.find_by(name: "veterinarian")
    t.save
  elsif stop_resource == "f"
    t.resource = Resource.find_by(name: "fuel")
    t.save
  elsif stop_resource == "O"
    t.resource = Resource.find_by(name: "outfitter")
    t.save
  elsif stop_resource == "H"
    t.resource = Resource.find_by(name: "hostel")
    t.save
  else
    binding.pry
  end

  puts "#{t.stop_name} #{stop_resource} saved"

end

# seed the Stopresources on the trail
csv_text2 = File.read(Rails.root.join('db', 'stop_resources_data.csv'))
csv2 = CSV.parse(csv_text2, headers: true, encoding: 'ISO-8859-1')

csv2.each do |row|

  stop_resources = row["name"]

  if stop_resources
    stop = Stop.find_by(name: row['stop_name'])
    if stop_resources.include? "–"
      #  binding.pry
    elsif stop_resources.include? ","
      stop_resource = stop_resources.split(',')
      stop_resource.each do |sr|
        parse_stop_resource_shorthand(sr, stop)
      end
    else
      parse_stop_resource_shorthand(stop_resources, stop)
    end
  end
end

# seed the Stopresources that aren't directly on the trail

stop = Stop.find_by(name: "Race Brook Falls Trail")
race1 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "campsites"), distance_from_trail: 0.2, direction_from_trail: "E")
race2 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "water"), distance_from_trail: 0.4, direction_from_trail: "E")
race3 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "road access"), distance_from_trail: 2.5, direction_from_trail: "E")
race4 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "parking"), distance_from_trail: 2.5, direction_from_trail: "E")

stop = Stop.find_by(name: "Jug End Road")
jug1 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "road access"), distance_from_trail: nil, direction_from_trail: nil)
jug2 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "parking"), distance_from_trail: nil, direction_from_trail: nil)
jug3 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "water"), distance_from_trail: 0.25, direction_from_trail: "W")

stop = Stop.find_by(name: "Mass. 41; Undermountain Road")
undermountain1 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "water"), distance_from_trail: 0.1, direction_from_trail: "W")
undermountain2 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "post office"), distance_from_trail: 1.2, direction_from_trail: "W")
undermountain3 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "meals, restaurants"), distance_from_trail: 1.2, direction_from_trail: "W")

stop = Stop.find_by(name: "U.S. 7")
seven1 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "post office"), distance_from_trail: 3.2, direction_from_trail: "E")
seven2 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "bus"), distance_from_trail: 3.2, direction_from_trail: "E")
seven3 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "groceries, supplies"), distance_from_trail: 3.2, direction_from_trail: "E")
seven4 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "lodging"), distance_from_trail: 3.2, direction_from_trail: "E")
seven5 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "meals, restaurants"), distance_from_trail: 3.2, direction_from_trail: "E")

seven6 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "groceries, supplies"), distance_from_trail: 1.5, direction_from_trail: "W")
seven7 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "meals, restaurants"), distance_from_trail: 1.5, direction_from_trail: "W")
seven8 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "post office"), distance_from_trail: 1.8, direction_from_trail: "W")
seven9 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "all"), distance_from_trail: 1.8, direction_from_trail: "W")

seven10 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "groceries, supplies"), distance_from_trail: 2.8, direction_from_trail: "W")
seven11 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "coin laundry"), distance_from_trail: 2.8, direction_from_trail: "W")

stop = Stop.find_by(name: "Ice Gulch; Tom Leonard Shelter")
ice1 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "shelter"), distance_from_trail: nil, direction_from_trail: nil)
ice2 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "water"), distance_from_trail: 0.2, direction_from_trail: "E")

stop = Stop.find_by(name: "Mass. 23")
mass231 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "road access"), distance_from_trail: nil, direction_from_trail: nil)
mass232 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "parking"), distance_from_trail: nil, direction_from_trail: nil)
mass233 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "post office"), distance_from_trail: 4.3, direction_from_trail: "E")
mass234 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "hostel"), distance_from_trail: 1.6, direction_from_trail: "W")
mass235 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "meals, restaurants"), distance_from_trail: 2.7, direction_from_trail: "W")
mass236 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "post office"), distance_from_trail: 4, direction_from_trail: "W")
mass237 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "all"), distance_from_trail: 4, direction_from_trail: "W")

stop = Stop.find_by(name: "Benedict Pond, Beartown State Forest ")
beartown1 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "campsites"), distance_from_trail: 0.5, direction_from_trail: "W")
beartown2 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "water"), distance_from_trail: 0.5, direction_from_trail: "W")

stop = Stop.find_by(name: "Mt. Wilcox North Shelter")
wilcox1 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "shelter"), distance_from_trail: 0.3, direction_from_trail: "E")
wilcox2 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "water"), distance_from_trail: 0.3, direction_from_trail: "E")

stop = Stop.find_by(name: "Fernside Road")
fernside1 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "road access"), distance_from_trail: nil, direction_from_trail: nil)
fernside2 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "parking"), distance_from_trail: nil, direction_from_trail: nil)
fernside3 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "road access"), distance_from_trail: 0.2, direction_from_trail: "W")

stop = Stop.find_by(name: "Jerusalem Road; spring")
jerusalem1 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "parking"), distance_from_trail: nil, direction_from_trail: nil)
jerusalem2 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "road access"), distance_from_trail: nil, direction_from_trail: nil)
jerusalem3 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "water"), distance_from_trail: nil, direction_from_trail: nil)
jerusalem4 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "short-term resupply"), distance_from_trail: nil, direction_from_trail: nil)
jerusalem5 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "post office"), distance_from_trail: 0.6, direction_from_trail: "W")
jerusalem6 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "lodging"), distance_from_trail: 0.6, direction_from_trail: "W")


stop = Stop.find_by(name: "Upper Goose Pond Cabin")
goose1 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "shelter"), distance_from_trail: 0.5, direction_from_trail: "W")
goose2 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "campsites"), distance_from_trail: 0.5, direction_from_trail: "W")
goose3 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "water"), distance_from_trail: 0.5, direction_from_trail: "W")

stop = Stop.find_by(name: "U.S. 20")
us201 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "road access"), distance_from_trail: nil, direction_from_trail: nil)
us202 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "parking"), distance_from_trail: nil, direction_from_trail: nil)
us203 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "lodging"), distance_from_trail: 0.1, direction_from_trail: "E")
us204 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "post office"), distance_from_trail: 5, direction_from_trail: "W")
us205 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "all"), distance_from_trail: 5, direction_from_trail: "W")

stop = Stop.find_by(name: "Washington Mountain Road, Pittsfield Road")
wash1 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "road access"), distance_from_trail: nil, direction_from_trail: nil)
wash2 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "parking"), distance_from_trail: nil, direction_from_trail: nil)
wash3 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "campsites"), distance_from_trail: 0.1, direction_from_trail: "E")
wash4 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "water"), distance_from_trail: 0.1, direction_from_trail: "E")
wash5 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "post office"), distance_from_trail: 5, direction_from_trail: "E")
wash6 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "lodging"), distance_from_trail: 5, direction_from_trail: "E")
wash7 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "doctor, medical"), distance_from_trail: 5, direction_from_trail: "E")
wash8 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "veterinarian"), distance_from_trail: 5, direction_from_trail: "E")

stop = Stop.find_by(name: "Kay Wood Shelter")
kay1 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "shelter"), distance_from_trail: 0.2, direction_from_trail: "E")
kay2 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "water"), distance_from_trail: 0.2, direction_from_trail: "E")

stop = Stop.find_by(name: "Crystal Mountain Campsite")
kay1 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "campsites"), distance_from_trail: 0.2, direction_from_trail: "E")
kay2 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "water"), distance_from_trail: 0.2, direction_from_trail: "E")


stop = Stop.find_by(name: "Church St., School St., Hiker Kiosk")
church1 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "road access"), distance_from_trail: nil, direction_from_trail: nil)
church2 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "post office"), distance_from_trail: nil, direction_from_trail: nil)
church3 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "bus"), distance_from_trail: nil, direction_from_trail: nil)
church4 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "meals, restaurants"), distance_from_trail: nil, direction_from_trail: nil)
church5 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "groceries, supplies"), distance_from_trail: nil, direction_from_trail: nil)
church6 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "water"), distance_from_trail: nil, direction_from_trail: nil)
church7 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "lodging"), distance_from_trail: 0.1, direction_from_trail: "W")

stop = Stop.find_by(name: "Mass. 8")
mass81 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "road access"), distance_from_trail: nil, direction_from_trail: nil)
mass82 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "lodging"), distance_from_trail: 0.8, direction_from_trail: "E")
mass83 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "outfitter"), distance_from_trail: 2.4, direction_from_trail: "E")
mass84 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "fuel"), distance_from_trail: 2.4, direction_from_trail: "E")
mass85 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "bus"), distance_from_trail: 4, direction_from_trail: "E")
mass86 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "groceries, supplies"), distance_from_trail: 4, direction_from_trail: "E")
mass87 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "lodging"), distance_from_trail: 4, direction_from_trail: "E")
mass88 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "meals, restaurants"), distance_from_trail: 4, direction_from_trail: "E")
mass89 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "doctor, medical"), distance_from_trail: 4, direction_from_trail: "E")
mass810 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "veterinarian"), distance_from_trail: 4, direction_from_trail: "E")
mass811 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "coin laundry"), distance_from_trail: 4, direction_from_trail: "E")
mass812 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "groceries, supplies"), distance_from_trail: 0.2, direction_from_trail: "W")

stop = Stop.find_by(name: "Mark Noepel Shelter")
mk1 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "shelter"), distance_from_trail: 0.2, direction_from_trail: "E")
mk2 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "campsites"), distance_from_trail: 0.2, direction_from_trail: "E")
mk3 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "water"), distance_from_trail: 0.2, direction_from_trail: "E")


stop = Stop.find_by(name: "Notch Road")
mk1 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "road access"), distance_from_trail: nil, direction_from_trail: nil)
mk2 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "parking"), distance_from_trail: nil, direction_from_trail: nil)
mk3 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "water"), distance_from_trail: 0.25, direction_from_trail: "E")

stop = Stop.find_by(name: "Wilbur Clearing Shelter")
wc1 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "shelter"), distance_from_trail: 0.3, direction_from_trail: "W")
wc2 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "campsites"), distance_from_trail: 0.3, direction_from_trail: "W")
wc3 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "water"), distance_from_trail: 0.3, direction_from_trail: "W")

stop = Stop.find_by(name: "Mass. 2; Hoosic River, railroad tracks overpass")
mass21 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "road access"), distance_from_trail: nil, direction_from_trail: nil)
mass22 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "parking"), distance_from_trail: nil, direction_from_trail: nil)
mass23 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "bus"), distance_from_trail: nil, direction_from_trail: nil)
mass24 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "groceries, supplies"), distance_from_trail: 0.6, direction_from_trail: "E")
mass25 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "meals, restaurants"), distance_from_trail: 0.6, direction_from_trail: "E")
mass26 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "coin laundry"), distance_from_trail: 0.6, direction_from_trail: "E")
mass27 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "shower"), distance_from_trail: 1, direction_from_trail: "E")
mass28 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "post office"), distance_from_trail: 2.5, direction_from_trail: "E")
mass29 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "bus"), distance_from_trail: 2.5, direction_from_trail: "E")
mass210 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "groceries, supplies"), distance_from_trail: 2.5, direction_from_trail: "E")
mass211 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "doctor, medical"), distance_from_trail: 2.5, direction_from_trail: "E")
mass212 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "veterinarian"), distance_from_trail: 2.5, direction_from_trail: "E")
mass213 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "coin laundry"), distance_from_trail: 2.5, direction_from_trail: "E")
mass214 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "meals, restaurants"), distance_from_trail: 2.5, direction_from_trail: "E")
mass215 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "lodging"), distance_from_trail: 2.5, direction_from_trail: "E")
mass216 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "groceries, supplies"), distance_from_trail: 0.4, direction_from_trail: "W")
mass217 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "lodging"), distance_from_trail: 0.4, direction_from_trail: "W")
mass218 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "outfitter"), distance_from_trail: 0.4, direction_from_trail: "W")
mass219 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "veterinarian"), distance_from_trail: 0.6, direction_from_trail: "W")
mass220 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "groceries, supplies"), distance_from_trail: 1.4, direction_from_trail: "W")
mass221 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "lodging"), distance_from_trail: 1.4, direction_from_trail: "W")
mass222 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "meals, restaurants"), distance_from_trail: 1.4, direction_from_trail: "W")
mass223 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "coin laundry"), distance_from_trail: 1.4, direction_from_trail: "W")
mass224 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "fuel"), distance_from_trail: 1.4, direction_from_trail: "W")
mass225 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "groceries, supplies"), distance_from_trail: 2.6, direction_from_trail: "W")
mass226 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "lodging"), distance_from_trail: 2.6, direction_from_trail: "W")
mass227 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "meals, restaurants"), distance_from_trail: 2.6, direction_from_trail: "W")
mass228 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "post office"), distance_from_trail: 2.6, direction_from_trail: "W")
mass229 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "bus"), distance_from_trail: 2.6, direction_from_trail: "W")
mass230 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "shower"), distance_from_trail: 2.6, direction_from_trail: "W")
mass231 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "doctor, medical"), distance_from_trail: 2.6, direction_from_trail: "W")

stop = Stop.find_by(name: "Massachusetts Avenue")
massave = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "meals, restaurants"), distance_from_trail: 0.6, direction_from_trail: "E")

stop = Stop.find_by(name: "Sherman Brook Primitive Campsite")
sb2 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "water"), distance_from_trail: nil, direction_from_trail: nil)
sb2 = Stopresource.create!(stop: stop, stop_name: stop.name, resource: Resource.find_by(name: "campsites"), distance_from_trail: 0.1, direction_from_trail: "W")
