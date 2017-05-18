# Store Journeys Informations
class Journey
  attr_reader :journeys_list, :trip

  PENALTY_FARE = 6

  def initialize
    @trip = {}
    @journeys_list = []
  end

  def in_journey?
    !!@trip[:entry]
  end

  def start_a_journey(station)
    @trip[:entry] = station
    @trip[:exit] = nil
  end

  def end_a_journey(station)
    @trip[:entry] ||= nil
    @trip[:exit] = station
    log_journey(station)
  end

  def fare
    return PENALTY_FARE if penalty?
    1
  end

  private

  def penalty?
    !@trip[:entry] && !@trip[:exit]
  end

  def log_journey(exit_station)
    @journeys_list << @trip
    @trip = {}
  end
end
