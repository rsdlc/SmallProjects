get '/posts/tags/postwithtags' do
  @tag = Tag.find_by_name(params[:name])
  if @tag != nil
    @posts = @tag.posts
    erb :postswithtags
  else
    erb :nopostsfound
  end
end

