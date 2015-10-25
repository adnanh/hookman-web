require 'sinatra'
require 'tilt/erubis'
require 'yaml'
require 'json'

set :config, YAML.load_file('config.yml')

set :bind, settings.config['server']['host'] || '127.0.0.1'
set :port, settings.config['server']['port'] || 9999

set :version, '0.0.1'

use Rack::Session::Cookie, :key => settings.config['server']['cookie']['name'],
                           :path => settings.config['server']['cookie']['path'],
                           :expire_after => settings.config['server']['cookie']['expire_after'],
                           :secret => settings.config['server']['cookie']['secret']

helpers do
	def protected!
		unless authenticated?
			redirect '/login'
		end
	end

	def authenticated?
		!session[:logged_in].nil? && session[:logged_in]
	end

	def flash(value=nil)
		if value.nil?
			session.delete :flash
		else
			session[:flash] = value
		end
	end

end

get '/' do 
	protected!

	hooks = JSON.parse(File.read(settings.config['webhook']['hooks']))

	erb :index, locals: { hooks: hooks }
end

get '/log' do 
	protected!

	log = File.readlines(settings.config['webhook']['log'])

	erb :log, locals: { log: log }
end

get '/login' do
	erb :login, locals: { message: flash }
end

post '/login' do
	if params[:username] == settings.config['auth']['username'] && params[:password] == settings.config['auth']['password']
		session[:logged_in] = true
	else
		flash '<b class="error">Invalid username/password combination.</b>'
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