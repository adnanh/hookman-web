require 'sinatra'

enable :sessions

get '/' do 
	erb :index
end

get '/login' do
	erb :login
end

post '/login' do
end

get '/logout' do
end

post '/update' do
end