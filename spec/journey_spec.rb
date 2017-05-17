require 'journey'

# @journey_list = [] ?? who's responsibility ??

=begin
in_journey?
start_a_journey (called by touch_in)
  -> record entry station
end_a_journey (called by touch_out)
  -> log_journey?
  -> set entry_station to nil
=end


describe Journey do
  subject(:journey) { described_class.new }

  let(:station) { double(:station) }
  let(:exit_station) { double(:station) }

  describe '#in_journey' do
    it 'knows whether it is in a journey' do
      expect(journey.in_journey?).to eq false
    end
  end

  describe '#start_a_journey' do
    it 'changes the @entry_station' do
      journey.start_a_journey(station)
      expect(journey.entry_station).to eq station
    end
  end

  describe '#end_a_journey' do
    it 'resets the entry stations' do
      journey.start_a_journey(station)
      journey.end_a_journey(exit_station)
      expect(journey.in_journey?).to eq false
    end

    it 'logs a completed journey' do
      p journey.start_a_journey(station)
      p journey.end_a_journey(exit_station)
      expect(journey.journeys).to eq [{ entry: station, exit: exit_station }]
    end
  end
end
