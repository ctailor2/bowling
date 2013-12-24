require_relative 'roll'

class Frame
	attr_reader :rolls, :bonus, :max_rolls
	attr_accessor :pins, :active

	def initialize(bonus = false)
		@rolls = []
		@pins = 10
		@bonus = bonus
		@max_rolls = 2
		@active = true
	end

	def roll
		rolls << Roll.new(pins)
		routine
	end

	def adjust_pin_count
		self.pins -= rolls.last.result
	end

	def deactivate?
		pins == 0 || rolls.length == max_rolls
	end

	def deactivate
		self.active = false
	end

	def routine
		adjust_pin_count
		deactivate if deactivate?
	end
end