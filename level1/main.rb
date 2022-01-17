require 'json'
require 'date'
require 'pry-byebug'
require_relative 'models/car'
require_relative 'models/rental'

CARS = []
filepath = 'level1/data/input.json'
input = JSON.parse(File.read(filepath))

input['cars'].each do |car|
  CARS << Car.new(id: car['id'], price_per_day: car['price_per_day'], price_per_km: car['price_per_km'])
end

def parse_rentals(input)
  rents = []
  input['rentals'].each do |rental|
    rents << Rental.new(id: rental['id'], car_id: rental['car_id'], start_date: rental['start_date'],
                        end_date: rental['end_date'], distance: rental['distance'])
  end
  rents
end

def price(rental)
  car = CARS.find { |c| c.id == rental.car_id }
  days_price = rental.number_of_days * car.price_per_day
  km_price = rental.distance * car.price_per_km
  days_price + km_price
end

rentals = { rentals: [] }

rents = parse_rentals(input)
rents.each do |rent|
  rentals[:rentals] << {
    id: rent.id,
    price: price(rent)
  }
end

def store_json(path, rentals)
  File.open(path, 'wb') do |file|
    file.write(JSON.pretty_generate(rentals))
  end
end

store_path = 'level1/data/output.json'
store_json(store_path, rentals)
