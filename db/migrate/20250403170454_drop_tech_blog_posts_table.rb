class DropTechBlogPostsTable < ActiveRecord::Migration[7.1]
  def up
    if table_exists?(:tech_blog_posts)
      drop_table :tech_blog_posts
    end
  end

  def down
    unless table_exists?(:tech_blog_posts)
      create_table :tech_blog_posts do |t|
        t.text :content
        t.boolean :is_embeded, default: false
        t.text :iframe_embed
        t.datetime :created_at, null: false
        t.datetime :updated_at, null: false
      end
    end
  end
end
