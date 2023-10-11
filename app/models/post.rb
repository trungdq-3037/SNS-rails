class Post < ApplicationRecord
    belongs_to :user, class_name: "User" , foreign_key: "user_id"
    belongs_to :like
    has_many :comments
    has_many :users, through: :comments

end
