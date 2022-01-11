require_relative '../level2/main'

def com(price)
  price - price * 0.7
end

def inssurance_fee(rent)
  com(decreases_price(rent)).to_i / 2
end

def assistance_fee(rent)
  rent.number_of_days * 100
end

def drivy_fee(rent)
  com(decreases_price(rent)).to_i / 2 - rent.number_of_days * 100
end

rents = []
filepath = 'level3/data/input.json'

input = JSON.parse(File.read(filepath))

input['rentals'].each do |rental|
  rents << Rental.new(id: rental['id'], car_id: rental['car_id'], start_date: rental['start_date'], end_date: rental['end_date'], distance: rental['distance'])
end

store_path = 'level3/data/output.json'

rentals = { rentals: [] }

rents.each do |rent|
  rentals[:rentals] << {
    id: rent.id,
    price: decreases_price(rent),
    commission: {
      insurance_fee: inssurance_fee(rent),
      assistance_fee: assistance_fee(rent),
      drivy_fee: drivy_fee(rent)
    }
  }
end

File.open(store_path, 'wb') do |file|
  file.write(JSON.generate(rentals))
end
