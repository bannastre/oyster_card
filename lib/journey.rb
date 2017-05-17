class Journey
  attr_reader :entry_station, :journeys

  def initialize
    @entry_station = nil
    @journeys = []
  end

  def in_journey?
    !!entry_station
  end

  def start_a_journey(station)
    @entry_station = station
  end

  def end_a_journey(station)
    log_journey(station)
    @entry_station = nil
  end

  private
  def log_journey(exit_station)
    journeys << { entry: entry_station, exit: exit_station }
  end
end
