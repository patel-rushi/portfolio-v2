puts "Seeding database..."

# --- Users ---
user = User.find_or_create_by!(email: "rushi@example.com") do |u|
  u.name = "Rushi Patel"
  u.password = "password"
  u.password_confirmation = "password"
end
puts "  Created user: #{user.email}"

# --- Posts ---
posts = [
  {
    title: "Building a Portfolio with Rails 7",
    content: "A deep-dive into setting up a modern portfolio site using Rails 7, Hotwire, and PostgreSQL. We cover project structure, deployment, and styling with Tailwind CSS.",
    category: "tech",
    published_at: 3.days.ago
  },
  {
    title: "Docker Basics for Rails Developers",
    content: "Getting started with Docker doesn't have to be intimidating. This post walks through containerizing a Rails app, running PostgreSQL in Docker, and common pitfalls.",
    category: "tech",
    published_at: 5.days.ago
  },
  {
    title: "Quick Tip: Postgres Roles",
    content: "A short note on managing PostgreSQL roles and permissions for local development. Covers CREATE ROLE, ALTER ROLE, and pg_hba.conf basics.",
    category: "notes",
    published_at: 1.week.ago
  },
  {
    title: "Automating Deployments with GitHub Actions",
    content: "How I set up a CI/CD pipeline using GitHub Actions to run tests, build a Docker image, and deploy to production on every push to main.",
    category: "notes",
    published_at: 2.weeks.ago
  },
  {
    title: "Bash Script: Bulk Image Resize",
    content: "A handy shell script that uses ImageMagick to batch-resize images for web. Accepts a directory and target width as arguments.",
    category: "scripts",
    published_at: 10.days.ago
  },
  {
    title: "Ruby One-Liner: CSV to JSON",
    content: "Convert a CSV file to JSON in a single Ruby command. Great for quick data transformations without pulling in extra dependencies.",
    category: "scripts",
    published_at: 12.days.ago
  },
  {
    title: "Day in the Life: Remote Dev Setup",
    content: "A quick reel showing my home office setup, the tools I use daily, and how I stay productive while working remotely.",
    category: "reels",
    url: "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
    published_at: 4.days.ago
  },
  {
    title: "Live Coding: Building a REST API",
    content: "Watch me build a simple REST API from scratch in Rails, complete with authentication and tests, in under 30 minutes.",
    category: "reels",
    url: "https://www.youtube.com/watch?v=dQw4w9WgXcQ",
    published_at: 1.month.ago
  }
]

posts.each do |attrs|
  post = Post.find_or_create_by!(title: attrs[:title]) do |p|
    p.assign_attributes(attrs)
  end
  puts "  Created post: [#{post.category}] #{post.title}"
end

puts "Done! Created #{User.count} user(s) and #{Post.count} post(s)."
