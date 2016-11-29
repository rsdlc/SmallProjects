class User < ActiveRecord::Base
  validates :name, uniqueness: true
  #============================ Tweet en el futuro ============================
 def tweet_later(text)
    twitter_user_id = TwitterUser.find_by(name:self.name).id
    tweet = Tweet.create(twitter_user_id:twitter_user_id,body:text)
    TweetWorker.perform_in(0.25.minutes,tweet.id)

    #La última linea debe de regresar un sidekiq job id
  end
#============================ Hace un tweet del usuario ====================
  def tweet(text)
    client = make_client
    client.update(text)
  end
#===========================================================================
#============================ Metodos privados =============================
#===========================================================================
  private
#============================ Junta los tweets =============================
  def collect_with_max_id(collection=[], max_id=nil, &block)
    response = yield(max_id)
    collection += response
    response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
  end
#============================ Crea un cliente =====================  
  def make_client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key    =   ENV['TWITTER_KEY']
      config.consumer_secret = ENV['TWITTER_SECRET']
      config.access_token        = self.token
      config.access_token_secret = self.secret_token
    end
    client
  end
#===========================================================================
#============================ Metodos Publicos =============================
#===========================================================================
  public
#============================ Busca los tweets de un usuario ===============
  def get_all_tweets(user)
    client = make_client
    collect_with_max_id do |max_id|
      options = {count: 200, include_rts: true}
      options[:max_id] = max_id unless max_id.nil?
      client.user_timeline(user, options)
    end
  end
#============================ Busca si existe un usuario ===================
  def user_exists?(user)
    client = make_client
    client.user(user)
    true
  rescue Twitter::Error::NotFound
    false
  end
#============================ Regresa un usuario, si existe ================
  def find_user(user)
    if user_exists?(user)
      client = make_client
      client.user(user)
    else
      nil
    end
  end
end
