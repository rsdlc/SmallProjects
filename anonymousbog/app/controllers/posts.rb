
get '/posts' do
  @posts = Post.all
  erb :posts
end

get '/posts/createpost' do
  erb :postcreated
end

get '/posts/findby/' do
  if Post.exists?(params[:id])
    @post = Post.find(params[:id])
    erb :findpost
  else
    erb :nopostsfound 
  end
end

post '/posts' do
  @post = Post.create!(title: params[:title], body: params[:body])
  @tags = params[:post][:tags]
  @tags.split(",").each do |tag| 
    nuevotag = Tag.find_or_create_by(name: tag)
    Relation.create!(post_id: @post.id, tag_id: nuevotag.id)
  end

  if @post != nil
    redirect '/posts/createpost'
  else
    "Hubo algun error tu post no fue creado"
  end
end

get '/posts/delete/:id' do
  @deletepost = Post.find(params[:id])
  @deletepost.destroy
  redirect '/posts'
end



get '/posts/edit/:id' do
  @editpost = Post.find(params[:id])
  erb :editpost
end

post '/posts/edit/:id' do
  @editpost = Post.find_by(id: params[:id])
  @editpost.update(title: params[:newtitle], body: params[:newbody])
  redirect '/'
end
