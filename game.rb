require_relative 'frame'

class Game
	attr_reader :frames, :current_frame

	def initialize
		@frames = []
		9.times do
			frames << Frame.new
		end
		frames << Frame.new(true)

		@current_frame = frames.first
	end
end