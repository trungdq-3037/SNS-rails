class Post < ApplicationRecord
  belongs_to :user
  has_many :like, dependent: :destroy
  has_many :comments, dependent: :destroy
  # has_many :users, through: :comments
  attr_reader :count_comment
  attr_reader :count_like, :current_user_liked

  def set_count_comment(count)
    @count_comment = count
  end

  def set_count_like(count)
    @count_like = count
  end

  def set_current_user_liked(liked)
    @current_user_liked = liked
  end
end
