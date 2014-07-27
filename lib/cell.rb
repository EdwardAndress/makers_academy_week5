require './lib/water.rb'

class Cell

	def initialize(content, letter, number)
		@content = content
		@shot_at = false
		@id = letter 
	end

	attr_accessor :content, :id

	def shot_at?
		@shot_at
	end

	def shoot!
		@shot_at = true
		@content.hit!	
	end

	def obj_id
		return @id
	end

	def status
		return 'X' if part_of_damaged_ship_here?
		return '~' if water_here? && !shot_at? || part_of_ship_here?
		return 'O' if water_here?
	end

	def water_here?
		content.class == Water
	end

	def part_of_ship_here?
		content.class.superclass == Ship
	end

	def part_of_damaged_ship_here?
		part_of_ship_here? && shot_at?
	end

end
