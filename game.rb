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
		unless over?
			current_frame.roll
			score_all_frames
		end
	end

	def score_frame(index)
		frame = frames[index]
		unless frame.active
			subsequent_frames = frames[index + 1..-1]
			if subsequent_frames.length > 0
				subsequent_rolls = subsequent_frames.flat_map { |frame| frame.rolls }
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
			else
				frame.score = frame.rolls.map { |roll| roll.result }.inject(:+)
			end
		end
		frame.score
	end

	def score_all_frames
		frames.each_with_index do |frame, index|
			score_frame(index)
		end
	end

	def running_score_upto(index)
		frame = frames[index]
		if frame.score
			frames[0..index].map { |frame| frame.score }.inject(:+)
		end
	end

	def over?
		frames.none? { |frame| frame.active }
	end
end