require 'sinatra/base'
require './lib/board.rb'
require './lib/player.rb'
require './lib/ship.rb'

class Battleships < Sinatra::Base
	set :views, settings.root + '/../views/'
  
  enable :sessions

  get '/' do
  	erb :index
  
  end

  get '/name' do
  	erb :name
  end

  post '/hello' do
  	session[:player1] = Player.new(name: params[:player1name], board: Board.new)
   # session[:player2] = Player.new(name: params[:player2name], board: Board.new)
  	erb :hello
  end

  get '/proceed' do 
    erb :proceed
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
