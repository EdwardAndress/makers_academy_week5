require 'sinatra/base'
require './lib/board.rb'
require './lib/player.rb'
require './lib/ship.rb'
require './lib/cell.rb'
require './lib/water.rb'
require './lib/coordinates'


class Battleships < Sinatra::Base
	set :views, settings.root + '/../views/'

  use Rack::Session::Cookie, :key => 'rack.session',
                           :path => '/',
                           :secret => 'your_secret'

  get '/' do
  	erb :index
  end

  get '/name' do
  	erb :name
  end

  post '/hello' do
    board = Board.new
  	me = Player.new(name: params[:player1name], board: board)
    session[:player1]= me
  	erb :hello
  end

  get '/place_boats' do 
    erb :place_boats
  end

  get '/shoot_boats' do 
    erb :shoot_boats
  end

  post '/shoot' do
    cell_key = params["cell_key"]
    session[:player1].board.grid[cell_key].shoot!
    erb :shoot_boats
  end

  post '/place_boat_part' do
    ship = params[ship]
    cell_key = params["cell_key"]
    session[:player1].board.grid[cell_key].content = session[:player1].ships_to_deploy.pop
    erb :place_boats
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
