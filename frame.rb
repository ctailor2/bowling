require_relative 'roll'

class Frame
	attr_reader :rolls, :bonus
	attr_accessor :pins, :active, :pin_set_roll_count, :score, :max_rolls, :autoreset

	def initialize(bonus = false)
		@rolls = []
		@pins = 10
		@bonus = bonus
		@max_rolls = 2
		@active = true
		@pin_set_roll_count = 1
		@score
		@autoreset
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
		increment_pin_set_roll_count
		apply_bonus if apply_bonus?
		reset_pins if reset_pins?
		deactivate if deactivate?
	end

	def increment_pin_set_roll_count
		self.pin_set_roll_count += 1
	end

	def has_strike?
		rolls.any? { |roll| roll.strike? }
	end

	def has_spare?
		rolls.any? { |roll| roll.spare? }
	end

	def reset_pins?
		autoreset && pins == 0
	end

	def reset_pins
		if active
			self.pins = 10
		end
	end

	def apply_bonus?
		bonus && (has_strike? || has_spare?)
	end

	def apply_bonus
		self.max_rolls = 3
		self.autoreset = true
	end
end