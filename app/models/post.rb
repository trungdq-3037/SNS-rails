class Post < ApplicationRecord
    belongs_to :user
    has_many :like, dependent: :destroy
    has_many :comments, dependent: :destroy
    # has_many :users, through: :comments

end
