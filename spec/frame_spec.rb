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
	end

	describe "#rolls" do
		it "is a collection" do
			expect(frame.rolls).to be_a(Array)
		end

		it "is empty to start" do
			expect(frame.rolls).to be_empty
		end
	end
end