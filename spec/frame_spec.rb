require_relative '../frame'

describe Frame do
	let(:frame) { Frame.new }

	describe "#initialize" do
		it "responds to rolls" do
			expect(frame).to respond_to(:rolls)
		end

		it "responds to pins" do
			expect(frame).to respond_to(:pins)
		end

		it "responds to bonus" do
			expect(frame).to respond_to(:bonus)
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
			frame.adjust_pin_count
			expect(frame.pins).to eq(3)
		end
	end
end