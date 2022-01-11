require_relative '../level3/main'


rents = []
filepath = 'level4/data/input.json'

input = JSON.parse(File.read(filepath))

input['rentals'].each do |rental|
  rents << Rental.new(id: rental['id'], car_id: rental['car_id'], start_date: rental['start_date'], end_date: rental['end_date'], distance: rental['distance'])
end

store_path = 'level4/data/output.json'

rentals = { rentals: [] }

rents.each do |rent|
  rentals[:rentals] << {
    id: rent.id,
    actions: [
        { who: "driver",type: "debit", amount: decreases_price(rent) },
        { who: "owner", type: "credit", amount: (decreases_price(rent) * 0.7).to_i },
        { who: "insurance", type: "credit", amount: inssurance_fee(rent) },
        { who: "assistance", type: "credit", amount: assistance_fee(rent) },
        { who: "drivy", type: "credit", amount: drivy_fee(rent) }
      ]
  }
end

File.open(store_path, 'wb') do |file|
  file.write(JSON.generate(rentals))
end
