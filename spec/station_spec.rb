require 'station'

describe Station do

  subject(:station) { Station.new(:zone, :name) }

  describe '#zone' do
    it "knows its zone" do
      expect(station.zone).to eq :zone
    end
  end

  describe '#name' do
    it "knows its name" do
      expect(station.name).to eq :name
    end
  end

end
