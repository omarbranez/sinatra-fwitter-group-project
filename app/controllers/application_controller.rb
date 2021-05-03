require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions #enable in order to use.
    set :session_secret, "fwecret"
  end

  get '/' do
    erb :index
  end

  helpers do # from sinatra-password-security lab
    def logged_in?
      !!session[:user_id] # double bang turns it into a boolean. double negative means true
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
