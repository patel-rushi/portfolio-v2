class Post < ApplicationRecord
  before_create :set_default_published_at

  validates :category, presence: true
  validates :title, presence: true
  validates :content, presence: true
  validates :remote_id, uniqueness: true, allow_nil: true

  private

  def set_default_published_at
    self.published_at ||= created_at || Time.current
  end
end