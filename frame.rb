require_relative 'roll'

class Frame
	attr_reader :rolls, :bonus, :max_rolls
	attr_accessor :pins, :active, :pin_set_roll_count

	def initialize(bonus = false)
		@rolls = []
		@pins = 10
		@bonus = bonus
		@max_rolls = 2
		@active = true
		@pin_set_roll_count = 0
	end

	def roll
		rolls << Roll.new(pins, pin_set_roll_count)
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

	def increment_pin_set_roll_count
		self.pin_set_roll_count += 1
	end
end