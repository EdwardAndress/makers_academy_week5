require './lib/ship'

describe Ship do

	let(:ship) { Ship.new(2) }

	it 'is floating when created' do
		expect(ship.floating?).to be true
	end

	it 'knows how many hits it can take' do
		expect(ship.remaining_hits).to eq 2
	end

	it 'can be shot at' do
		allow(STDOUT).to receive(:puts)
		ship.hit!
		expect(ship.remaining_hits).to eq 1
	end

	it 'can be sunk' do
		allow(STDOUT).to receive(:puts)
		ship.hit!
		expect(ship).to be_floating
		ship.hit!
		expect(ship).not_to be_floating
	end
end