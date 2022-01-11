class Rental
  attr_accessor :id
  attr_reader :start_date, :end_date, :distance, :car_id

  def initialize(attributes = {})
    @start_date = attributes[:start_date]
    @end_date = attributes[:end_date]
    @id = attributes[:id]
    @car_id = attributes[:car_id]
    @distance = attributes[:distance]
  end

  def number_of_days
    (Date.parse(@end_date) - Date.parse(@start_date)).to_i + 1
  end
end
