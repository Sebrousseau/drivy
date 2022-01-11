class Car
  attr_accessor :id
  attr_reader :price_per_day, :price_per_km

  def initialize(attributes = {})
    @price_per_day = attributes[:price_per_day]
    @price_per_km = attributes[:price_per_km]
    @id = attributes[:id]
  end
end
