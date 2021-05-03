class TweetsController < ApplicationController
    get '/tweets' do
        if logged_in? # they should ONLY see this content if they're logged in. 
            # otherwise, they MUST have to login
            @tweets = Tweet.all
            erb :'tweets/tweets'
        else
            redirect '/login'
        end
    end

    get '/tweets/new' do
        if logged_in?
            erb :'tweets/new'
        else
            redirect '/login'
        end
    end

    post '/tweets' do
        if logged_in?
            if params[:content] == ""
                redirect '/tweets/new' # tweet cannot be blank. make them try again
            else
                # binding.pry
                @tweet = current_user.tweets.create(content: params[:content])
                #build allows you to add a record into a has_many relationship BEFORE SAVING IT. but why? just create it. unless you want to prompt to save.
                @tweet.save
                redirect to "/tweets/#{@tweet.id}"
            end
        else
            redirect '/login'
        end
    end

    get '/tweets/:id' do
        if logged_in?           
            @tweet = Tweet.find(params[:id])
            # binding.pry
            erb :'tweets/show_tweet'
        else
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find(params[:id])
            if @tweet && @tweet.user == current_user
                #if the tweet exists, and that tweet's user is the one currently logged in...
            erb :'tweets/edit_tweet'
            else
                redirect '/tweets'
            end
        else
            redirect '/login'
        end
    end

    patch '/tweets/:id' do
        # binding.pry # used to show where the artist is in params
        if logged_in?
            if params[:content] == ""
                redirect to "/tweets/#{params[:id]}/edit" # we havent given it the dignity of assigning it as an instance yet
            else
                @tweet = Tweet.find(params[:id])
                if @tweet && @tweet.user == current_user
                    @tweet.update(content: params[:content])
                    redirect to "/tweets/#{@tweet.id}"
                else
                    redirect to "/tweets/#{@tweet.id}"
                end
            end
        else
            redirect '/login'
        end
    end

    delete '/tweets/:id/delete' do
        if logged_in?
          @tweet = Tweet.find(params[:id])
          if @tweet && @tweet.user == current_user
            @tweet.delete
          end
          redirect to '/tweets'
        else
          redirect to '/login'
        end
      end

end
