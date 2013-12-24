require_relative '../game'

describe Game do
	let(:game) { Game.new }

	describe "#initialize" do
		it "responds to #frames" do
			expect(game).to respond_to(:frames)
		end

		it "responds to #current_frame" do
			expect(game).to respond_to(:current_frame)
		end
	end

	describe "#frames" do
		it "is a collection of frames" do
			expect(game.frames.all?{ |frame| frame.is_a? Frame }).to be_true
		end

		it "has a length of 10" do
			expect(game.frames.length).to eq(10)
		end

		specify "first 9 frames are not bonus type" do
			expect(game.frames.first(9).all?{ |frame| frame.bonus == false }).to be_true
		end

		specify "last frame is bonus type" do
			expect(game.frames.last.bonus).to be_true
		end
	end

	describe "#current_frame" do
		it "starts with the first frame" do
			expect(game.current_frame).to eq(game.frames.first)
		end

		context "when the current frame is inactive" do
			before { game.current_frame.deactivate }

			it "returns the first active frame" do
				expect(game.current_frame).to eq(game.frames[1])
			end

			it "does not return the current inactive frame" do
				expect(game.current_frame).not_to eq(game.frames[0])
			end
		end
	end
end