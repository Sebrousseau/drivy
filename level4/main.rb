require_relative '../level3/main'

filepath = 'level4/data/input.json'
input = JSON.parse(File.read(filepath))
rents = parse_rentals(input)

rentals = { rentals: [] }

rents.each do |rent|
  rentals[:rentals] << {
    id: rent.id,
    actions: [
      { who: 'driver', type: 'debit', amount: decreases_price(rent) },
      { who: 'owner', type: 'credit', amount: (decreases_price(rent) * 0.7).to_i },
      { who: 'insurance', type: 'credit', amount: inssurance_fee(rent) },
      { who: 'assistance', type: 'credit', amount: assistance_fee(rent) },
      { who: 'drivy', type: 'credit', amount: drivy_fee(rent) }
    ]
  }
end

store_path = 'level4/data/output.json'
store_json(store_path, rentals)
