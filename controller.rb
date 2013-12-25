require_relative 'game'

helpers do
	def new_game
		session[:game] = Game.new
	end

	def current_game
		session[:game]
	end

	def game_on?
		!session[:game].nil?
	end

	def reset
		session.clear
	end

	def frames
		current_game.frames
	end
end

get '/' do
	reset
	erb :index
end

post '/' do
	reset
	new_game
	erb :index
end

post '/roll' do
	current_game.roll
	erb :index
end