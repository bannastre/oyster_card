require 'station'

describe Station do
  subject(:station) { described_class.new(:zone, :name) }

  describe '#zone' do
    it 'knows its name' do
      expect(station.zone).to eq :zone
    end
  end

  describe '#name' do
    it 'knows its name' do
      expect(station.name).to eq :name
    end
  end
end
