class UsersController < ApplicationController
     
    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        # binding.pry # used to find that @artist.songs is nested
        erb :'users/show'
    end

    get '/signup' do
        if !logged_in?
            erb :'/users/create_user'
        else
            redirect '/tweets'
        end
    end

    post '/signup' do
        if params[:username] != "" && params[:email] != "" && params[:password] != "" # all three have to exist
            @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
            @user.save
            session[:user_id] = @user.id # the current session user_id is the current instance's user.id
            redirect '/tweets'
        else
            redirect '/signup'
        end
    end

    get '/login' do
        if logged_in?
            redirect '/tweets' # they shouldnt see the login page if they're already logged in
        else
            erb :'users/login'
        end
    end

    post '/login' do
        user = User.find_by_slug(params[:username]) # not an instance variable since we aren't passing anything to erb
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/tweets'
        else
            redirect '/signup' #locals: message: perhaps -> "Try again" message?
        end
    end

    get '/logout' do
        if logged_in?
            session.clear # instead of destroy?
            redirect '/login'
        else
            redirect '/'
        end
    end

end
