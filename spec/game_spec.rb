require_relative '../game'

describe Game do
	let(:game) { Game.new }

	describe "#initialize" do
		it "responds to #frames" do
			expect(game).to respond_to(:frames)
		end 
	end

	describe "#frames" do
		it "is a collection of frames" do
			expect(game.frames.all?{ |frame| frame.is_a? Frame }).to be_true
		end

		it "has a length of 10" do
			expect(game.frames.length).to eq(10)
		end
	end
end