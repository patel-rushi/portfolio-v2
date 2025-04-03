class Post < ApplicationRecord
    validates :category, presence: true
    validates :title, presence: true
    validates :content, presence: true
    validates :remote_id, uniqueness: true, allow_nil: true
  end