require_relative 'frame'

class Game
	attr_reader :frames

	def initialize
		@frames = []
		9.times do
			frames << Frame.new
		end
		frames << Frame.new(true)

		@current_frame = frames.first
	end

	def current_frame
		frames.find { |frame| frame.active }
	end
end