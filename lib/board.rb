require './lib/cell'

class Board

	def initialize(content: Water.new)
		@grid = create_new_grid_with(content)
	end

	def grid
		@grid
	end

	def place(ship_type, at_coordinates)
		at_coordinates.locations.each do |location|
			grid[location].content = ship_type
		end
	end

	def render_display
		rows_of_cells.each_slice(10).map { |el| el }
	end

	def nice_display
		render_display.each{|row| p row}
	end

	private

	def rows_of_cells
		grid.values.map{|cell| cell.status}
	end
	
	def create_new_grid_with(content)
		("A".."J").map { |letter| (1..10).map { |number| {"#{letter}#{number}" => Cell.new(content) } } }.flatten.inject(&:merge)
	end

end