require_relative 'frame'

class Game
	attr_reader :frames

	def initialize
		@frames = []
		10.times do
			frames << Frame.new
		end
	end
end