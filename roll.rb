class Roll
	attr_reader :pins, :result

	def initialize(pins)
		@pins = pins
		@result = Kernel.rand(0..pins)
	end
end