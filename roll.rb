class Roll
	attr_reader :pins, :result, :pin_set_roll_count

	def initialize(pins, pin_set_roll_count)
		@pins = pins
		@pin_set_roll_count = pin_set_roll_count
		@result = Kernel.rand(0..pins)
	end

	def strike?
		result == pins && pin_set_roll_count == 1
	end
end