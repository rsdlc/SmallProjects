class CreateComment < ActiveRecord::Migration
  def change
    create_table :comments do |t| 
      t.string :body
      t.string :author
    end
  end
end
