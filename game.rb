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

	def roll
		current_frame.roll
	end

	def score_frame(index)
		frame = frames[index]
		unless frame.active
			subsequent_rolls = frames[index + 1..-1].flat_map { |frame| frame.rolls }
			if frame.has_strike?
				if subsequent_rolls.length >= 2
					frame.score = (frame.rolls + subsequent_rolls.first(2)).map { |roll| roll.result }.inject(:+)
				end
			elsif frame.has_spare?
				if subsequent_rolls.length >= 1
					frame.score = (frame.rolls + subsequent_rolls.first(1)).map { |roll| roll.result }.inject(:+)
				end
			else
				frame.score = frame.rolls.map { |roll| roll.result }.inject(:+)
			end
		end
	end
end