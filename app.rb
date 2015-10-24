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
		unless authenticated?
			redirect '/login'
		end
	end

	def authenticated?
		!session[:logged_in].nil? && session[:logged_in]
	end
end

get '/' do 
	protected!

	erb :index, locals: { test: "welcome" }
end

get '/login' do
	erb :login
end

post '/login' do
	if params[:username] == settings.config['auth']['username'] && params[:password] == settings.config['auth']['password']
		session[:logged_in] = true
	end

	redirect '/'
end

get '/logout' do
	if session[:logged_in]
		session.delete(:logged_in)
	end

	redirect '/'
end

post '/update' do
	protected!
	"ada"
end