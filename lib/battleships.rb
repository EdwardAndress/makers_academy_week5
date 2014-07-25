require 'sinatra/base'
require './lib/board.rb'
require './lib/player.rb'
require './lib/ship.rb'
require './lib/cell.rb'
require './lib/water.rb'
require './lib/coordinates'
require './lib/game.rb'


class Battleships < Sinatra::Base
	set :views, settings.root + '/../views/'

  use Rack::Session::Cookie, :key => 'rack.session',
                           :path => '/',
                           :secret => 'your_secret'

  enable :sessions
  GAME = Game.new

  get '/' do
    puts session[:player1]
    puts GAME.players
  	erb :index
  end

  get '/name' do
    erb :name
  end

  post '/name' do 
    session[:player1]=params[:name]
    board = Board.new
    GAME.add Player.new(name: session[:player1], board: board)
    redirect to('/waiting_to_start')
  end

  get '/restart' do 
    GAME.restart
    redirect to('/')
  end

  get '/waiting_to_start' do 
      if GAME.start?
      "Lets go!"
    else
     "Lets wait for another player to join."
    end
  end
  # post '/hello' do
  
  # 	erb :name
  # end

  # get '/new_game' do
  #   erb :new_game
  # end

  # post '/hello' do

 
  # end

  get '/place_boats' do 
    erb :place_boats
  end

  get '/shoot_boats' do 
    erb :shoot_boats
  end

  post '/shoot' do
    cell_key = params["cell_key"]
    session[:player].board.grid[cell_key].shoot!
    erb :shoot_boats
  end

  post '/place_boat_part' do
    ship = session[:player].ships_to_deploy.last
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

    already_a_boat = coordinates.any?{|co| session[:player].board.grid[co].part_of_ship_here?} if test_if.valid? 

    if already_a_boat == false
      coordinates.each do |cell|
        session[:player].board.grid[cell].content = ship
      end
      session[:player].ships_to_deploy.pop
    end
    if !session[:player].ships_to_deploy.empty?
      erb :place_boats
    else
      erb :shoot_boats
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
