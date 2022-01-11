require_relative '../level2/main'

def com(price)
  price - price * 0.7
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
      insurance_fee: com(decreases_price(rent)).to_i / 2,
      assistance_fee: rent.number_of_days * 100,
      drivy_fee: com(decreases_price(rent)).to_i / 2 - rent.number_of_days * 100
    }
  }
end

File.open(store_path, 'wb') do |file|
  file.write(JSON.generate(rentals))
end
