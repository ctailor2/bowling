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

	describe "#roll" do
		it "rolls the current frame" do
			expect(game.current_frame).to receive(:roll)
			game.roll
		end
	end

	describe "#score_frame" do
		context "on active frames" do
			it "does not set the frame's score" do
				Kernel.stub(:rand).and_return(5)
				frame = game.frames.first
				frame.roll
				game.score_frame(0)
				expect(frame.score).to be_nil
			end
		end

		context "on inactive frames" do
			describe "on the first 9 frames" do
				context "when the frame is a strike" do
					describe "where the next frames have at least 2 rolls" do
						context "across 1 frame" do
							it "correctly sets the frame's score" do
								Kernel.stub(:rand).and_return(10, 4, 3)
								frame = game.frames.first
								game.roll
								game.roll
								game.roll
								game.score_frame(0)
								expect(frame.score).to eq(17)
							end
						end

						context "across 2 frames" do
							it "correctly sets the frame's score" do
								Kernel.stub(:rand).and_return(10, 10, 3)
								frame = game.frames.first
								game.roll
								game.roll
								game.roll
								game.score_frame(0)
								expect(frame.score).to eq(23)
							end
						end
					end

					describe "where the next frames have less than 2 rolls" do
						context "across 1 frame" do
							it "does not set the frame's score" do
								Kernel.stub(:rand).and_return(10, 3)
								frame = game.frames.first
								game.roll
								game.roll
								game.score_frame(0)
								expect(frame.score).to be_nil
							end
						end

						context "across 2 frames" do
							it "does not set the frame's score" do
								Kernel.stub(:rand).and_return(10, 10)
								frame = game.frames.first
								game.roll
								game.roll
								game.score_frame(0)
								expect(frame.score).to be_nil
							end
						end
					end
				end

				context "when the frame is a spare" do
					describe "where the next frames have at least 1 roll" do
						it "correctly sets the frame's score" do
							Kernel.stub(:rand).and_return(8, 2, 3)
							frame = game.frames.first
							game.roll
							game.roll
							game.roll
							game.score_frame(0)
							expect(frame.score).to eq(13)
						end
					end

					describe "where the next frames have less than 1 roll" do
						it "does not set the frame's score" do
							Kernel.stub(:rand).and_return(8, 2)
							frame = game.frames.first
							game.roll
							game.roll
							game.score_frame(0)
							expect(frame.score).to be_nil
						end
					end
				end

				context "when the frame is neither a strike nor a spare" do
					it "correctly sets the frame's score" do
						Kernel.stub(:rand).and_return(3, 2)
						frame = game.frames.first
						game.roll
						game.roll
						game.score_frame(0)
						expect(frame.score).to eq(5)
					end
				end
			end

		end
	end
end