module Seeds
  def self.comment
    Comment.transaction do
      comment1 = Comment.create(body:"Me gusta el post. No sé mucho acerca de programación pero me encantaría saber más.", author: "Juan Gómez")
    end    
  end
end

Seeds.comment