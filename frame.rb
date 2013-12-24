# require_relative 'roll'

class Frame
	attr_reader :rolls, :pins

	def initialize
		@rolls = []
		@pins = 10
	end
end