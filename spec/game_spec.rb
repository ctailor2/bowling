require_relative '../game'

describe Game do
	let(:game) { Game.new }

	describe "#initialize" do
		it "responds to #frames" do
			expect(game).to respond_to(:frames)
		end 
	end
end