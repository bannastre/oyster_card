require_relative 'station'
require_relative 'journey'

# Responsible for keeping a travellers balance and trips
class Oystercard
  attr_reader :balance, :journey

  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journey = Journey.new
  end

  def top_up(amount)
    raise "Maximum balance of £#{BALANCE_LIMIT} exceeded" if over_limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise 'Balance below minimum.' if @balance < MINIMUM_FARE
    touch_out(nil) if @journey.trip[:entry]
    @journey.start_a_journey(station)
  end

  def touch_out(station)
    @journey.end_a_journey(station)
    deduct_fare(@journey.fare)
    @journey.reset_trip
  end

  def retrieve_journey_history
    @journey.journeys_list
  end

  private

  def deduct_fare(amount)
    @balance -= amount
  end

  def over_limit?(amount)
    (@balance + amount) > BALANCE_LIMIT
  end
end
