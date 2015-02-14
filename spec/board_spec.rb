require './lib/board'

describe Board do
	context 'at initialization' do
		it 'uses a hash for the grid' do
			board = Board.new
			expect(board.grid.class).to eq Hash
		end

		it 'has 100 key-value pairs' do
			board = Board.new
			expect(board.grid.length).to eq 100
		end

		it 'has some content in each cell' do
			board = Board.new
			board.grid.values.each do |cell|
				expect(cell.content.class).to eq Water
			end
		end
	end

	context 'placing ships' do
		it 'can place a ship' do
			cell           = double :cell
			board          = Board.new(content: cell)
			ship           = double :ship
			locations      = ['A1']
			location       = 'A1'
			at_coordinates = double :coordinates, locations: locations

			expect(at_coordinates.locations).to receive(:each).and_yield(location)
			expect(board.grid[location]).to receive(:content=).with(ship)

			board.place(ship, at_coordinates)
		end
	end

end