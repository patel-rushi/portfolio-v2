# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Post.create!([
    { title: 'Notes Post', content: 'This is the notes post.', category: 'notes', published_at: Time.now },
    { title: 'Scripts Post', content: 'This is the scripts post.', category: 'scripts', published_at: Time.now },
    { title: 'Reels Post', content: 'This is the reels post.', category: 'reels', published_at: Time.now },
    { title: 'Tech Post', content: 'This is the tech post.', category: 'tech', published_at: Time.now }
  ])