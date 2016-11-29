class CreateRelations < ActiveRecord::Migration
  def change
    create_table :relations do |t|
      t.belongs_to :post, index: true
      t.belongs_to :tag, index: true
    end
  end
end
