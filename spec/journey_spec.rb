require 'journey'

describe Journey do
  subject(:journey) { described_class.new }
  let(:station) { double(:station) }
  let(:exit_station) { double(:station) }
  let(:oystercard) { double(:oystercard) }

  describe '#in_journey' do
    it 'knows whether it is in a journey' do
      expect(journey.in_journey?).to eq false
    end
  end

  describe '#start_a_journey' do
    it 'changes the @entry_station' do
      journey.start_a_journey(station)
      expect(journey.trip[:entry]).to eq station
    end
  end

  describe '#end_a_journey' do
    it 'resets the entry stations' do
      journey.start_a_journey(station)
      journey.end_a_journey(exit_station)
      expect(journey.in_journey?).to eq false
    end

    it 'logs a completed journey' do
      journey.start_a_journey(station)
      journey.end_a_journey(exit_station)
      expect(journey.journeys_list).to eq [{ entry: station, exit: exit_station }]
    end
  end

  describe '#fare' do
    it 'returns the penalty fare by default' do
      expect(journey.fare).to eq Journey::PENALTY_FARE
    end
  end
end
