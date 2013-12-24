describe Roll do
	let(:roll) { Roll.new(10, 1) }

	describe "#initialize" do
		it "responds to #pins" do
			expect(roll).to respond_to(:pins)
		end

		it "responds to #result" do
			expect(roll).to respond_to(:result)
		end

		it "responds to #pin_set_roll_count" do
			expect(roll).to respond_to(:pin_set_roll_count)
		end

		it "sets #result to a random number" do
			Kernel.stub(:rand).and_return(3)
			expect(roll.result).to eq(3)
		end
	end

	describe "#pins" do
		it "returns the number of pins available to the roll" do
			expect(roll.pins).to eq(10)
		end
	end

	describe "#result" do
		context "when there are 10 pins" do
			it "is less than or equal to the pins" do
				expect(roll.result).to be <= roll.pins
			end

			it "is not greater than the pins" do
				expect(roll.result).not_to be > roll.pins
			end
		end

		context "when there are 5 pins" do
			let(:roll) { Roll.new(5, 2) }

			it "is less than or equal to the pins" do
				expect(roll.result).to be <= roll.pins
			end

			it "is not greater than the pins" do
				expect(roll.result).not_to be > roll.pins
			end
		end
	end

	describe "#pin_set_roll_count" do
		it "returns the roll number for the current pin set" do
			expect(roll.pin_set_roll_count).to eq(1)
		end
	end
end