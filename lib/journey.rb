# Store Journeys Informations
class Journey
  attr_reader :entry_station, :journeys_list

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
    # @entry_station = station
  end

  def end_a_journey(station)
    @trip[:entry] ||= nil
    @trip[:exit] = station
    log_journey(station)
    # @entry_station = nil
  end

  private

  def log_journey(exit_station)
    @journeys_list << @trip
    @trip = {}
  end
end
