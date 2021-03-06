require 'oystercard'

RSpec.describe Oystercard do
  subject(:card) { Oystercard.new }

  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station) }

  it 'have a starting default balance of zero.' do
    expect(card.balance).to eq 0
  end

  it 'it should not be in a journey be default' do
    expect(card.journey).to eq nil
  end

  it 'resets the entry stations' do
   card.top_up(Oystercard::MINIMUM_FARE)
   card.touch_in(entry_station)
   card.touch_out(exit_station)
   expect(card.journey.trip).to eq({})
 end


  describe '#top_up' do
    it 'can top up the balance with desired amount' do
      expect { card.top_up(1) }.to change { card.balance }.to 1
    end

    it 'raises an error if the maximum balance is exceeded' do
      card.top_up(Oystercard::BALANCE_LIMIT)
      expect { card.top_up(1) }.to raise_error "Maximum balance of £#{Oystercard::BALANCE_LIMIT} exceeded"
    end
  end

  describe '#touch_in' do
    let(:station) { double(:station) }

    it "raise error if balance is below £#{Oystercard::MINIMUM_FARE}" do
      expect { card.touch_in(station) }.to raise_error 'Balance below minimum.'
    end
  end

  describe '#touch_out' do

    it "deducts #{Oystercard::MINIMUM_FARE} from balance" do
      card.top_up(Oystercard::MINIMUM_FARE)
      card.touch_in(entry_station)
      expect { card.touch_out(exit_station) }.to change { card.balance }.by(-Oystercard::MINIMUM_FARE)
    end
  end

  describe '#retrieve_journey_history' do

    it 'returns a list for one journey' do
      card.top_up(Oystercard::MINIMUM_FARE)
      card.touch_in(entry_station)
      card.touch_out(exit_station)
      expect(card.retrieve_journey_history).to eq [{ entry: entry_station, exit: exit_station }]
    end
  end
end
