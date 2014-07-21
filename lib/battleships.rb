require 'sinatra/base'

class Battleships < Sinatra::Base
	set :views, '../views/'
  
  get '/' do
  	erb :index
    'Hello Battleships!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
