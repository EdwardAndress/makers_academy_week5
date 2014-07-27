class Game

	attr_reader :players

	def initialize
		@players = []
	end

	def add(player)
		@players << player
	end

	def print_players
		"#{players.join('and')} are currently playing battleships"
	end

	def start?
		@players.count == 2
	end

	def restart
		@players = []
	end

	def return(player_name)
		@players.find{|player| player.name == player_name}
	end

	def return_opponent(player_name)
		@players.find{|opponent| opponent.name != player_name}
	end

end