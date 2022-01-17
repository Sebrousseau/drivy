require_relative '../level1/main'
require 'pry-byebug'

def reduce10(price)
  price * 0.9
end

def reduce30(price)
  price * 0.7
end

def reduce50(price)
  price * 0.5
end

def daily_price(days, car)
  reduce_price = 0
  price_per_day = car.price_per_day
  if days > 10
    reduce_price = (days - 10) * reduce50(price_per_day) + 6 * reduce30(price_per_day) + 3 * reduce10(price_per_day)
  elsif days > 4
    reduce_price = (days - 4) * reduce30(price_per_day) + 3 * reduce10(price_per_day)
  elsif days > 1
    reduce_price = (days - 1) * reduce10(price_per_day)
  end
  reduce_price.to_i + car.price_per_day
end

def decreases_price(rental)
  car = CARS.find { |c| c.id == rental.car_id }
  km_price = rental.distance * car.price_per_km
  daily_price(rental.number_of_days, car) + km_price
end

filepath = 'level2/data/input.json'
input = JSON.parse(File.read(filepath))
rents = parse_rentals(input)

rentals = { rentals: [] }

rents.each do |rent|
  rentals[:rentals] << {
    id: rent.id,
    price: decreases_price(rent)
  }
end

store_path = 'level2/data/output.json'
store_json(store_path, rentals)
