class CreateTechBlogPosts < ActiveRecord::Migration[7.1]
  def change
    create_table :tech_blog_posts do |t|
      t.text :content
      t.boolean :is_embeded, default: false
      t.text :iframe_embed

      t.timestamps
    end
  end
end
