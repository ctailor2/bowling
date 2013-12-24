require_relative 'roll'

class Frame
	attr_reader :rolls, :bonus
	attr_accessor :pins

	def initialize(bonus = false)
		@rolls = []
		@pins = 10
		@bonus = bonus
	end

	def roll
		rolls << Roll.new(pins)
	end

	def adjust_pin_count
		self.pins -= rolls.last.result
	end
end