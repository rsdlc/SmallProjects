get '/' do
  # La siguiente linea hace render de la vista 
  # que esta en app/views/index.erb
  @comments = Comment.all
  erb :index
end

post '/comment/new' do
comment = Comment.create(body: params[:comentario], author: params[:autor])
  if comment
    return "true"
  else
    nil
  end
end