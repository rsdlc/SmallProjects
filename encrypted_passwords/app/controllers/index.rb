enable :sessions

get '/' do
  if session[:user_id]
    @user = User.find(session[:user_id])
    erb :userpage
  else
    erb :index
  end
end

post '/logout' do
  session.clear
  redirect '/'
end

post '/user/register' do
  @user = User.create!(name: params[:name], email: params[:email])
  @user.password = params[:password]
  @user.save
  session[:user_id] = @user.id
  erb :userpage, layout: false
end

post '/user/update' do
  @user = User.find(session[:user_id])
  @user.update!(email: params[:newemail], password: params[:newpassword])
  erb :userpage, layout: false
end

post '/user/delete' do
  @user = User.find(session[:user_id])
  @user.destroy
  session.clear
  erb :index, layout: false
end

post '/user/login' do
  p params
  @user = User.authenticate(params[:email],params[:password])
  if @user
    session[:user_id] = @user.id
    erb :userpage, layout: false
  else
    "ERROR FATAL"
  end
end