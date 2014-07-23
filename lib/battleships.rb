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
    puts me.object_id
  	erb :hello
  end

  get '/proceed' do 
    erb :proceed
  end

  post '/shoot' do
    object_id = params["object_id"]
    puts object_id.inspect
    session[:player1].board.grid.values.find {|cell| cell.id == object_id}
    erb :proceed
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
