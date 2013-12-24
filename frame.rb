require_relative 'roll'

class Frame
	attr_reader :rolls, :pins, :bonus

	def initialize(bonus = false)
		@rolls = []
		@pins = 10
		@bonus = bonus
	end

	def roll
		rolls << Roll.new(pins)
	end
end