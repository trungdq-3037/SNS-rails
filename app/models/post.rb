class Post < ApplicationRecord
    belongs_to :user
    has_many :like
    has_many :comments
    # has_many :users, through: :comments

end
