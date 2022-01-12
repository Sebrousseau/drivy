class Option
  attr_accessor :id
  attr_reader :type, :rental_id

  def initialize(attributes = {})
    @id = attributes[:id]
    @rental_id = attributes[:rental_id]
    @type = attributes[:type]
  end

  OPTIONS_PRICES = { 'owner': [{ 'gps': 5, 'baby_seat': 2 }],
                     'Getaround': [{ 'additional_insurance': 10 }] }
end
