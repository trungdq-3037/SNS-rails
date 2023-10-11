class User < ApplicationRecord
    has_many :posts, dependent: :destroy
    has_many :comments,  dependent: :destroy
    has_many :posts, through: :comments
    
    has_secure_password


end
