class Player

	def initialize(name: 'SomeName', board: :a_board)
		@name            = name
		@board           = board
		@ships_to_deploy = [PatrolBoat.new, Submarine.new, Destroyer.new, Battleship.new, Carrier.new]
		@turn_counter = 0
	end

	attr_reader :name, :board, :ships_to_deploy
	attr_accessor :turn_counter

	def shoot_at(opponent_board, at_coordinate)
		opponent_board.grid[at_coordinate].shoot!
	end

	def take_turn
		@turn_counter += 2
	end

end