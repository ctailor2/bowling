require_relative 'frame'

class Game
	attr_reader :frames

	def initialize
		@frames = []
		9.times do
			frames << Frame.new
		end
		frames << Frame.new(true)
	end
end