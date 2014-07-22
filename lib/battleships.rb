require 'sinatra/base'

class Battleships < Sinatra::Base
	set :views, settings.root + '/../views/'
  
  get '/' do
  	erb :index
  end

  get '/name' do
  	erb :name
  end