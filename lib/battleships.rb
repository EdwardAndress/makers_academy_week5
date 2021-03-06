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

  use Rack::Session::Cookie,  :key => 'rack.session',
                              :path => '/',
                              :secret => 'your_secret'

  GAME = Game.new

  get '/' do
    puts session[:player]
    puts GAME.players
  	erb :index
  end

  get '/name' do
    erb :name
  end

  post '/name' do 
    session[:player] = params[:name]
    board = Board.new
    GAME.add Player.new(name: session[:player], board: board)
    if GAME.start?
      redirect to ('/place_boats')
    else
      redirect to ('/waiting_to_start')
    end
  end

  get '/restart' do 
    GAME.restart
    redirect to('/')
  end

  get '/waiting_to_start' do 
    if GAME.start?
      redirect to ('/place_boats')
    else
     erb :waiting_to_start
    end
  end
  
  get '/place_boats' do 
    @player = GAME.return(session[:player])
    erb :place_boats
  end

  post '/place_boat_part' do
    @player = GAME.return(session[:player])
    @ship = @player.ships_to_deploy.last
    orientation = params["orientation"]
    p params["orientation"].inspect
    
    cell_key = params["cell_key"].split(//,2)
    row = cell_key[0]
    column = cell_key[1]

    coordinates ||= []
    already_a_boat = nil

    @ship.remaining_hits.times do
      coordinates << (row + column.to_s)
      orientation == "horizontal" ? column = column.next : row = row.next
    end

    test_if = Coordinates.new(coordinates)

    already_a_boat = coordinates.any?{|co| @player.board.grid[co].part_of_ship_here?} if test_if.valid? 

    if already_a_boat == false
      coordinates.each do |cell|
        @player.board.grid[cell].content = @ship
      end
      @player.floating_ships << @player.ships_to_deploy.pop
    end
    if @player.ships_to_deploy.empty?
      redirect to ('/wait_for_opponent_to_place_boats')
    else
      erb :place_boats
    end
  end

  get '/wait_for_opponent_to_place_boats' do 
    @player = GAME.return(session[:player])
    @opponent = GAME.return_opponent(session[:player])
    if @opponent.ships_to_deploy.empty?
      redirect to ('/wait_for_opponent_to_shoot')
    else
      @opponent.turn_counter += 1 if @opponent.turn_counter < 1
      puts @opponent.turn_counter
      erb :wait_for_opponent_to_place_boats
    end
  end

   get '/shoot_boats' do 
    @player = GAME.return(session[:player])
    @opponent = GAME.return_opponent(session[:player])
    redirect to ('/end_of_game') if @player.floating_ships.empty?
    erb :shoot_boats
  end

  post '/shoot' do
    @player = GAME.return(session[:player])
    @opponent = GAME.return_opponent(session[:player])
    cell_key = params["cell_key"]
    @opponent.board.grid[cell_key].shoot!
    @opponent.check_for_sunken_ships
    @player.take_turn
    redirect to ('/end_of_game') if @opponent.floating_ships.empty?
    redirect to ('/wait_for_opponent_to_shoot')
  end

  get '/wait_for_opponent_to_shoot' do 
    @player = GAME.return(session[:player])
    @opponent = GAME.return_opponent(session[:player])
    if @player.turn_counter < @opponent.turn_counter
      redirect to ('/shoot_boats')
    else
      erb :wait_for_opponent_to_shoot
    end
  end

  get '/end_of_game' do
    @player = GAME.return(session[:player])
    @opponent = GAME.return_opponent(session[:player])
    erb :end_of_game
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
