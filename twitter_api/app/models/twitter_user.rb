class TwitterUser < ActiveRecord::Base
  has_many :tweets
  validates :name, uniqueness: true
#============================ Verifica que un usuario este actualizado =====
  def update?(user)
    unless self.tweets.empty?
      twDB = self.tweets.first.body
      twWEB = user.get_all_tweets(self.name).first.text
      twDB == twWEB
    else
      false
    end
  end
#============================ Actualiza a un la BD  ========================
  def update!(user)
    Tweet.where(twitter_user_id:self.id).destroy_all
    tweets = user.get_all_tweets(self.name).take(10)
    tweets.each do |tweet|
      tw = Tweet.create(twitter_user_id:self.id,body:tweet.text)
    end
    self.tweets.count == 10 
  end
end