# Defines a new Oystercard
class Oystercard
  attr_reader :balance, :entry_station, :journey_list

  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @journey_list = []
  end

  def top_up(amount)
    raise "Maximum balance of £#{BALANCE_LIMIT} exceeded" if @balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    raise 'Balance below minimum.' if @balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    log_journey(station)
    @entry_station = nil
  end

  private

  def log_journey(exit_station)
    journey_list << { entry: entry_station, exit: exit_station }
  end

  def deduct(amount)
    @balance -= amount
  end
end
