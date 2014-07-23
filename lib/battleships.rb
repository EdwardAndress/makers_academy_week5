require 'sinatra/base'
require './lib/board.rb'
require './lib/player.rb'
require './lib/ship.rb'
require './lib/cell.rb'
require './lib/water.rb'
require './lib/coordinates'


class Battleships < Sinatra::Base
	set :views, settings.root + '/../views/'
  set :session_secret, "My session secret"

  enable :sessions

  get '/' do
  	erb :index
  
  end

  get '/name' do
  	erb :name
  end

  post '/hello' do
  	session[:player1] = Player.new(name: params[:player1name], board: Board.new)
  	erb :hello
  end

  get '/proceed' do 
    erb :proceed
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
