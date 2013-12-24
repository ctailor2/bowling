require_relative '../frame'

describe Frame do
	let(:frame) { Frame.new }

	describe "#initialize" do
		it "responds to #rolls" do
			expect(frame).to respond_to(:rolls)
		end

		it "responds to #pins" do
			expect(frame).to respond_to(:pins)
		end

		it "responds to #bonus" do
			expect(frame).to respond_to(:bonus)
		end

		it "responds to #max_rolls" do
			expect(frame).to respond_to(:max_rolls)
		end

		it "responds to #active" do
			expect(frame).to respond_to(:active)
		end

		it "responds to #pin_set_roll_count" do
			expect(frame).to respond_to(:pin_set_roll_count)
		end

		it "responds to #score" do
			expect(frame).to respond_to(:score)
		end
	end

	describe "#rolls" do
		it "is a collection" do
			expect(frame.rolls).to be_a(Array)
		end

		it "is empty to start" do
			expect(frame.rolls).to be_empty
		end
	end

	describe "#pins" do
		it "starts at 10" do
			expect(frame.pins).to eq(10)
		end
	end

	describe "#bonus" do
		context "when bonus is not specified" do
			specify "is false" do
				expect(frame.bonus).to be_false
			end
		end

		context "when bonus is specified" do
			let(:frame) { Frame.new(true) }

			specify "is true" do
				expect(frame.bonus).to be_true	
			end
		end
	end

	describe "#max_rolls" do
		it "starts at 2" do
			expect(frame.max_rolls).to eq(2)
		end
	end

	describe "#active" do
		it "starts as active" do
			expect(frame.active).to be_true
		end
	end

	describe "#pin_set_roll_count" do
		it "starts at 1" do
			expect(frame.pin_set_roll_count).to eq(1)
		end
	end

	describe "#score" do
		it "starts with no score" do
			expect(frame.score).to be_nil
		end
	end

	describe "#roll" do
		it "creates a roll in the rolls collection" do
			frame.roll
			expect(frame.rolls.first).to be_a(Roll)
		end
	end

	describe "#adjust_pin_count" do
		it "reduces the pins by the result of the last roll" do
			Kernel.stub(:rand).and_return(7)
			frame.roll
			expect(frame.pins).to eq(3)
		end
	end

	describe "#deactivate?" do
		context "for non-bonus type frames" do
			describe "when the number of rolls reaches max rolls" do
				it "returns true" do
					Kernel.stub(:rand).and_return(3)
					frame.roll
					frame.roll
					expect(frame.deactivate?).to be_true
				end
			end

			describe "when the number of rolls is less than max rolls" do
				it "returns false" do
					Kernel.stub(:rand).and_return(3)
					frame.roll
					expect(frame.deactivate?).to be_false
				end
			end

			describe "when the number of pins is zero" do
				it "returns true" do
					Kernel.stub(:rand).and_return(10)
					frame.roll
					expect(frame.deactivate?).to be_true
				end
			end

			describe "when the number of pins is greater than zero" do
				it "returns false" do
					Kernel.stub(:rand).and_return(3)
					frame.roll
					expect(frame.deactivate?).to be_false
				end
			end
		end

		context "for bonus type frames" do
			it "NEEDS EXAMPLES ONCE BONUS ROUTINE IMPLEMENTED"
		end
	end

	describe "#deactivate" do
		it "deactivates the frame" do
			expect{frame.deactivate}.to change{frame.active}.from(true).to(false)
		end
	end

	describe "#increment_pin_set_roll_count" do
		it "increments the pin_set_roll_count by 1" do
			expect{frame.increment_pin_set_roll_count}.to change{frame.pin_set_roll_count}.by(1)
		end
	end

	describe "#has_strike?" do
		context "any of the rolls in the frame is a strike" do
			it "returns true" do
				Kernel.stub(:rand).and_return(10)
				frame.roll
				expect(frame.has_strike?).to be_true
			end
		end

		context "none of the rolls in the frame is a strike" do
			it "returns false" do
				Kernel.stub(:rand).and_return(5)
				frame.roll
				frame.roll
				expect(frame.has_strike?).to be_false
			end
		end
	end

	describe "#has_spare?" do
		context "any of the rolls in the frame is a spare" do
			it "returns true" do
				Kernel.stub(:rand).and_return(5)
				frame.roll
				frame.roll
				expect(frame.has_spare?).to be_true
			end
		end

		context "none of the rolls in the frame is a strike" do
			it "returns false" do
				Kernel.stub(:rand).and_return(3)
				frame.roll
				frame.roll
				expect(frame.has_spare?).to be_false
			end
		end
	end

	describe "#reset_pins?" do
		context "when the number of pins is 0" do
			it "returns true" do
				Kernel.stub(:rand).and_return(10)
				frame.roll
				expect(frame.reset_pins?).to be_true
			end
		end

		context "when the number of pins is greater than 0" do
			it "returns false" do
				Kernel.stub(:rand).and_return(3)
				frame.roll
				expect(frame.reset_pins?).to be_false
			end
		end
	end

	describe "#reset_pins" do
		it "resets the pins to 10" do
			Kernel.stub(:rand).and_return(10)
			frame.roll
			expect{frame.reset_pins}.to change{frame.pins}.from(0).to(10)
		end
	end
end