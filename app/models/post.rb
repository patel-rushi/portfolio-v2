class Post < ApplicationRecord
  before_create :set_default_published_at

  validates :category, presence: true
  validates :title, presence: true
  validates :content, presence: true
  validates :remote_id, uniqueness: true, allow_nil: true

  # Matches title or content text; HTML tags are stripped so markup doesn't match.
  def self.search(query)
    query = query.to_s.strip.first(100)
    return all if query.blank?

    pattern = "%#{sanitize_sql_like(query)}%"
    where("title ILIKE :q OR regexp_replace(content, '<[^>]*>', ' ', 'g') ILIKE :q", q: pattern)
  end

  private

  def set_default_published_at
    self.published_at ||= created_at || Time.current
  end
end