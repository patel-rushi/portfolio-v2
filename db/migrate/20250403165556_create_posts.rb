class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :category
      t.string :title
      t.text :content
      t.datetime :published_at

      t.timestamps
    end
  end
end
