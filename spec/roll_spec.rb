describe Roll do
	let(:roll) { Roll.new(10) }

	describe "#initialize" do
		it "responds to #pins" do
			expect(roll).to respond_to(:pins)
		end

		it "responds to #result" do
			expect(roll).to respond_to(:result)
		end
	end

	describe "#pins" do
		it "returns the number of pins available to the roll" do
			expect(roll.pins).to eq(10)
		end
	end
end