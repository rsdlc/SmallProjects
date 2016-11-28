require 'uri'
enable :sessions
get '/' do
   # La siguiente linea hace render de la vista 
   # que esta en app/views/index.erb
   erb :index
end

post '/urls' do
  current_user
    if @current_user
      @newurl = Url.create!(long_url: params[:long_url], click_count: 0, user_id: "#{@current_user.id}")
      "Your shortened url is #{@newurl[:short_url]}"
    else  
      @newurl = Url.create!(long_url: params[:long_url], click_count: 0)
      "Your shortened url is #{@newurl[:short_url]}"
    end
end

post '/login' do
   user = User.authenticate(params[:email], params[:password])  
   if user != nil then
     session["user"] ||= user.name
     current_user
     redirect '/userpage'
   else
     erb :login
   end
end

get '/logout' do
     session["user"] = nil
     erb :index
end
 
get '/login' do
     erb :login
end
 
get '/register' do
   erb :register
end
 
before '/userpage' do
   if session["user"] == nil
     erb :index
   else 
     erb :userpage
   end
end
 
get '/userpage' do
     if session["user"] == nil
     erb :index
   else 
     erb :userpage
   end
end

post '/accreated' do
   user = User.create!(name: params[:name], email: params[:email], password: params[:password])
   @name = user.name.upcase
   erb :acccreated
end

get '/:short_url' do
    @urls = Url.all
    @urloriginal = @urls.find_by(short_url: params[:short_url])

    if @urloriginal != nil then redirect @urloriginal.nuevourl
    else erb :index
  end
end

get '/users/:id' do
  # current_user
  # p @current_user
  @userurls = Url.where(user_id: params[:id])
  p "userurls equivale a: "
  p @userurls
  @purosurls = @userurls.pluck(:long_url)
  @puroclickcount = @userurls.pluck(:click_count)
  @todo = @purosurls.zip(@puroclickcount)
  print "la clase de userurls es: #{@userurls.class}\n" 
  
  erb :pagina
end
