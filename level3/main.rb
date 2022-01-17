require_relative '../level2/main'

def com(price)
  price * 0.3
end

def inssurance_fee(rent)
  com(decreases_price(rent)).to_i / 2
end

def assistance_fee(rent)
  rent.number_of_days * 100
end

def drivy_fee(rent)
  inssurance_fee(rent) - assistance_fee(rent)
end

filepath = 'level3/data/input.json'
input = JSON.parse(File.read(filepath))
rents = parse_rentals(input)

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

store_path = 'level3/data/output.json'
store_json(store_path, rentals)
