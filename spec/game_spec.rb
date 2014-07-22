require './lib/game'

describe Game do

	let(:player_one) { Player.new(name: 'PlayerOne', board: Board.new(content: Water.new)) }
	let(:player_two) { Player.new(name: 'PlayerOne', board: Board.new(content: Water.new)) }
	let(:game)       { Game.new(player_one: player_one, player_two: player_two)            }

	it 'is initialized with two players' do
		expect(game.player_one).to eq player_one
		expect(game.player_two).to eq player_two
	end

	context 'deploying the ships' do
		it 'a player to deploy it\'s ships' do
			allow(game).to receive(:gets).and_return('A1 A2 A3 A4 A5 A6',
																								 'D4 D5 D6 D7 D8',
																								 'E2 F2 G2 H2',
																								 'F4 G4 H4',
																								 'J3 J4')
			game.deploy_ships_for(player_one)
			expect(player_one.ships_to_deploy).to eq []
		end

		it 'will not allow to deploy ships, unless it is done properly :)' do
			expect(STDOUT).to receive(:puts).exactly(6).times.and_return("Be careful! The ship is 5 long,the coordinates have to be sequential and you must not have ships on top of eachother!!" )
			allow(game).to receive(:gets).and_return('A1 A2 A3 A4 A5 A6',
																								'A1 B1 C1 D1 E1',	
																								'D4 D5 D6 D7 D8',
																							  'E2 F2 G2 H2',
																								'F4 G4 H4',
																								'J3 J4')
			game.deploy_ships_for(player_one)
			expect(player_one.ships_to_deploy).to eq []
		end
 	end

 	context 'playing' do
 		it 'knows when a player has no more ships floating' do
 			allow(game).to receive(:gets).and_return('A1 A2 A3 A4 A5 A6',
																								 'D4 D5 D6 D7 D8',
																								 'E2 F2 G2 H2',
																								 'F4 G4 H4',
																								 'J3 J4')
			game.deploy_ships_for(player_one)

			expect(game.has_ships_floating?(player_one)).to be true

			player_two.shoot_at(player_one.board, 'A1')
			player_two.shoot_at(player_one.board, 'A2')
			player_two.shoot_at(player_one.board, 'A3')
			player_two.shoot_at(player_one.board, 'A4')
			player_two.shoot_at(player_one.board, 'A5')
			player_two.shoot_at(player_one.board, 'A6')
			player_two.shoot_at(player_one.board, 'D4')
			player_two.shoot_at(player_one.board, 'D5')
			player_two.shoot_at(player_one.board, 'D6')
			player_two.shoot_at(player_one.board, 'D7')
			player_two.shoot_at(player_one.board, 'D8')
			player_two.shoot_at(player_one.board, 'E2')
			player_two.shoot_at(player_one.board, 'F2')
			player_two.shoot_at(player_one.board, 'G2')
			player_two.shoot_at(player_one.board, 'H2')
			player_two.shoot_at(player_one.board, 'F4')
			player_two.shoot_at(player_one.board, 'G4')
			player_two.shoot_at(player_one.board, 'H4')
			player_two.shoot_at(player_one.board, 'J3')
			player_two.shoot_at(player_one.board, 'J4')

			expect(game.has_ships_floating?(player_one)).to be false
 		end
 	end 
end