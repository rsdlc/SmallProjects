class TweetWorker
  include Sidekiq::Worker

  def perform(tweet_id)
    # tweet = # Encuentra el tweet basado en el 'tweet_id' pasado como argumento
    tweet = Tweet.find(tweet_id)
    # user  = # Utilizando relaciones deberás encontrar al usuario relacionado con dicho tweet
    user = User.find_by(name:tweet.twitter_user.name)
    # Manda a llamar el método del usuario que crea un tweet (user.tweet)
    user.tweet(tweet.body)
  end
end
