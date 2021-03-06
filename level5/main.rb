require_relative '../level4/main'
require_relative '../level1/models/option'
require 'pry-byebug'
def additional_opt(option, rent)
  additional = { owner: 0, drivy: 0 }
  case option.type
  when 'gps'
    additional[:owner] = 500 * rent.number_of_days
  when 'baby_seat'
    additional[:owner] = 200 * rent.number_of_days
  when 'additional_insurance'
    additional[:drivy] = 1000 * rent.number_of_days
  end
  additional
end

options = []
filepath = 'level5/data/input.json'
input = JSON.parse(File.read(filepath))
rents = parse_rentals(input)

input['options'].each do |option|
  options << Option.new(id: option['id'], rental_id: option['rental_id'], type: option['type'])
end

rentals = { rentals: [] }

rents.each do |rent|
  add = { owner: 0, drivy: 0 }
  opt = options.select { |option| rent.id == option.rental_id }
  opt.each do |o|
    add[:owner] += additional_opt(o, rent)[:owner]
    add[:drivy] += additional_opt(o, rent)[:drivy]
  end
  rentals[:rentals] << {
    id: rent.id,
    options: opt.map(&:type),
    actions: [
      { who: 'driver', type: 'debit', amount: decreases_price(rent) + add[:owner] + add[:drivy] },
      { who: 'owner', type: 'credit', amount: (decreases_price(rent) * 0.7).to_i + add[:owner] },
      { who: 'insurance', type: 'credit', amount: inssurance_fee(rent) },
      { who: 'assistance', type: 'credit', amount: assistance_fee(rent) },
      { who: 'drivy', type: 'credit', amount: drivy_fee(rent) + add[:drivy] }
    ]
  }
end

store_path = 'level5/data/output.json'
store_json(store_path, rentals)
