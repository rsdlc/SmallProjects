class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.belongs_to :twitter_user , index: true
      t.string :body    
    end
  end
end