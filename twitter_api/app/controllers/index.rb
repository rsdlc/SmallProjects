#=======================================================================
get '/' do
  if logged_in? 
    erb :index
  else
    erb :login
  end
end
#=======================================================================
post '/fetch' do 
  if current_user.user_exists?(params[:user])
     redirect "/#{params[:user]}"
  else
     nil 
  end
end
# =======================================================================
post '/tweet' do
  tweet = params[:tweet]
  if tweet 
    current_user.tweet_later("#{tweet}")
  else
    return nil
  end
end
#=======================================================================
post '/tweet_status' do
  redirect "/status/#{params[:job_id]}"
end
#=======================================================================
get '/sign_in' do
  redirect request_token.authorize_url(:oauth_callback => "http://#{host_and_port}/auth")
end
#=======================================================================
get '/auth' do
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  session.delete(:request_token)
  user = User.find_by(name:@access_token.params[:screen_name])
  unless user
    user = User.create(name:@access_token.params[:screen_name].downcase,token:@access_token.params[:oauth_token],secret_token:@access_token.params[:oauth_token_secret])
  end
  twitter_current_user = TwitterUser.find_or_create_by(name:@access_token.params[:screen_name].downcase)
  session[:user_id] = user.id    
  session[:twitter_user_id] = twitter_current_user.id    
  redirect to '/'
end

#================================================================
get '/status/:job_id' do
  if job_is_complete(params[:job_id])
    "true"
  else
    "false"
  end
end
#=======================================================================
get '/logout' do
  session.clear
  redirect '/'
end
#=======================================================================
get '/:handle' do
  @user = TwitterUser.find_or_create_by(name:params[:handle])
  if @user
    if @user.tweets.empty? || !@user.update?(current_user)
      @user.update!(current_user)      
    end
      @tweets = @user.tweets
  end
  erb :tweets , layout: false
end
  # Para el signout no olvides borrar el hash de session
#=======================================================================

