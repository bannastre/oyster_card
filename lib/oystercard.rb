require_relative 'station'
require_relative 'journey'

# Defines a new Oystercard
class Oystercard
  attr_reader :balance

  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize(journey = Journey.new)
    @balance = 0
    @journey = journey
  end

  def top_up(amount)
    raise "Maximum balance of £#{BALANCE_LIMIT} exceeded" if @balance + amount > BALANCE_LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise 'Balance below minimum.' if @balance < MINIMUM_FARE
    @journey.start_a_journey(station)
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @journey.end_a_journey(station)
  end

  def retrieve_journey_history
    @journey.journeys_list
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
