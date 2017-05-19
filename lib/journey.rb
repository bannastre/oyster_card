# Store Journeys Informations
class Journey
  attr_reader :entry_station, :journeys_list, :current_journey

  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  def initialize
    @current_journey = {}
    @journeys_list = []
  end

  def in_journey?
    !!@current_journey[:entry]
  end

  def start_a_journey(station)
    @current_journey[:exit] = nil
    @current_journey[:entry] = station
  end

  def end_a_journey(station)
    @current_journey[:entry] ||= nil
    @current_journey[:exit] = station
    log_journey(station)
  end

  def fare
    return MINIMUM_FARE unless penalty?
    return PENALTY_FARE
  end

  private

  def penalty?
    @current_journey[:entry].nil?
  end

  def log_journey(exit_station)
    @journeys_list << @current_journey
    @current_journey = {}
  end
end
