class Option
  attr_reader :type, :rental_id, :id

  def initialize(attributes = {})
    @id = attributes[:id]
    @rental_id = attributes[:rental_id]
    @type = attributes[:type]
  end
end
