class Car
  attr_reader :price_per_day, :price_per_km, :id

  def initialize(attributes = {})
    @price_per_day = attributes[:price_per_day]
    @price_per_km = attributes[:price_per_km]
    @id = attributes[:id]
  end
end
