require_relative 'roll'

class Frame
	attr_reader :rolls, :pins

	def initialize
		@rolls = []
		@pins = 10
	end

	def roll
		rolls << Roll.new(pins)
	end
end