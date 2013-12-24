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
end