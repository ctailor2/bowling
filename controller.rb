require_relative 'game'

get '/' do
	game = Game.new
	@frames = game.frames
	erb :index
end