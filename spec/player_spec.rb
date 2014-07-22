require './lib/player'

describe Player do
	it 'has a name' do
		player = Player.new(name: 'Mihai')
		expect(player.name).to eq 'Mihai'
	end

	it 'has a board' do
		player = Player.new(board: :a_board)
		expect(player.board).to eq :a_board
	end

	it 'is initialized with all the ships he needs to deploy' do
		player = Player.new
		expect(player.ships_to_deploy.count).to eq 5
	end

	it 'can shoot at opponets board' do
		player         = Player.new
		opponent_board = double :board
		opponent_grid  = double :grid
		at_coordinate  = double :coordinates
		cell           = double :cell

		expect(opponent_board).to receive(:grid).and_return(opponent_grid)
		expect(opponent_grid).to receive(:[]).with(at_coordinate).and_return(cell)
		expect(cell).to receive(:shoot!)

		player.shoot_at(opponent_board, at_coordinate)
	end
end