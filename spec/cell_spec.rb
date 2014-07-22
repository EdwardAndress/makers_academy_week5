require './lib/cell' 

describe Cell do

	let(:water)           { double :water,  class: Water }
	let(:ship)            { double :ship, class: Ship    }
	let(:cell_with_water) { Cell.new(water)              }
	let(:cell_with_ship)  { Cell.new(ship)               }

	it 'has some content' do
		expect(cell_with_water.content).to eq water
	end

	it 'can have the content changed' do
		cell_with_water.content = :ship
		expect(cell_with_water.content).to eq :ship
	end

	it 'is not shot when created' do
		expect(cell_with_water.shot_at?).to be false
	end

	it 'can be shot at' do
		expect(cell_with_ship.content).to receive(:hit!)
		cell_with_ship.shoot!
		expect(cell_with_ship).to be_shot_at
	end

	context 'to string' do

		before(:each) do
			allow(Ship).to receive(:superclass).and_return(Ship)
		end

		it 'returns " " if water here and not shot at' do
			expect(cell_with_water.status).to eq ' '
		end

		it 'returns "S" if ship here' do
			expect(cell_with_ship.status).to eq 'S'
		end

		it 'returns "O" if water here and shot at' do
			allow(water).to receive(:hit!)
			cell_with_water.shoot!
			expect(cell_with_water.status).to eq 'O'
		end

		it 'returns "X" if damaged ship here' do
			allow(ship).to receive(:hit!)
			cell_with_ship.shoot!
			expect(cell_with_ship.status).to eq 'X'
		end
	end
end