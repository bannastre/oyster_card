# Responsible for holding station information
class Station
  attr_reader :zone, :name

  def initialize(zone, name)
    @zone = zone
    @name = name
  end
end
