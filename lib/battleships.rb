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
    ship = session[:player1].ships_to_deploy.last
    orientation = params["orientation"]
    p params["orientation"].inspect
    
    cell_key = params["cell_key"].split(//,2)
    row = cell_key[0]
    column = cell_key[1]

    coordinates ||= []
    already_a_boat = nil

    ship.remaining_hits.times do
      coordinates << (row + column.to_s)
      orientation == "horizontal" ? column = column.next : row = row.next
    end

    test_if = Coordinates.new(coordinates)

    already_a_boat = coordinates.any?{|co| session[:player1].board.grid[co].part_of_ship_here?} if test_if.valid? 

    if already_a_boat == false
      coordinates.each do |cell|
        session[:player1].board.grid[cell].content = ship
      end
      session[:player1].ships_to_deploy.pop
    end
    if !session[:player1].ships_to_deploy.empty?
      erb :place_boats
    else
      erb :shoot_boats
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
