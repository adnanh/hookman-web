require 'sinatra'
require 'tilt/erubis'
require 'yaml'

enable :sessions

set :config, YAML.load_file('config.yml')

set :bind, settings.config['server']['host'] || '127.0.0.1'
set :port, settings.config['server']['port'] || 9999

set :version, '0.0.1'

helpers do
	def protected!
	end

	def authenticated?
	end
end

get '/' do 
	erb :index, locals: { test: "ok" }
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