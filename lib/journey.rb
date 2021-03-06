# Responsible for Storing Journey Informations
class Journey
  attr_reader :journeys_list, :trip

  PENALTY_FARE = 6

  def initialize
    @trip = {}
    @journeys_list = []
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
    @trip = {}
  end

  private

  def penalty?
    @trip[:entry].nil? || @trip[:exit].nil?
  end

  def log_journey
    @journeys_list << @trip
  end
end
