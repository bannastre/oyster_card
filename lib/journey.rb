# Responsible for Storing Journey Informations
class Journey
  attr_reader :journeys_list, :trip

  PENALTY_FARE = 6

  def initialize
    @trip = {}
    @journeys_list = []
  end

  def in_journey?
    !@trip[:entry].nil?
  end

  def start_a_journey(station)
    @trip[:entry] = station
    @trip[:exit] = nil
  end

  def end_a_journey(station)
    @trip[:entry] ||= nil
    @trip[:exit] = station
    log_journey
  end

  def fare
    return PENALTY_FARE if penalty?
    Oystercard::MINIMUM_FARE
  end

  private

  def penalty?
    !@trip[:entry] && !@trip[:exit]
  end

  def log_journey
    @journeys_list << @trip
    @trip = {}
  end
end
