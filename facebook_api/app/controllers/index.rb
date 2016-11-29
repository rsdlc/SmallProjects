
get '/' do
  # La siguiente linea hace render de la vista 
  # que esta en app/views/index.erb
  if session[:user_id]
    @user = User.find(session[:user_id])
    @facebook = @user.facebook
    erb :index
  else
    erb :login
  end
end

get '/auth/:provider/callback' do
  user = User.from_omniauth(env["omniauth.auth"])
  # env["omniauth.auth"] es un objeto que contiene la información necesaria para crear nuestro usuario después de haber sido autenticados.
  # Esto se lo tenemos que mandar como argumento al método que crea al usuario.
  # Usa el método que creamos anteriormente para crear a tu usuario
  # Inicia su sesión
  if user
    session[:user_id] = user.id
  end
  # Redirige a su perfil
  redirect to "/"
end

get "/logout" do 
  session.clear
  redirect to "/"
end

# fb.get_connections('me','friends',:fields=>"name")