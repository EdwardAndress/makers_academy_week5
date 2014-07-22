require 'sinatra/base'

class Battleships < Sinatra::Base
	set :views, settings.root + '/../views/'
  
  get '/' do
  	erb :index
  end

  get '/name' do
  	erb :name
  end

  post '/hello' do
  	@name = params[:playername]
  	erb :hello
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
