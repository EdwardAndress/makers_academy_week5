require './lib/game'

describe Game do

	let(:player_one) { Player.new(name: 'PlayerOne', board: Board.new(content: Water.new)) }
	let(:player_two) { Player.new(name: 'PlayerOne', board: Board.new(content: Water.new)) }
	let(:game)       { Game.new           												}

	before(:each) do
		game.add(player_one)
		game.add(player_two)
	end

	it 'is initialized with two players' do
		expect(game.players[0]).to eq player_one
		expect(game.players[1]).to eq player_two
	end

end