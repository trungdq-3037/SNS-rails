json.success true
json.message 'success'
json.data do
  json.array! @posts do |post|
    json.partial! 'post_details', post: post
  end
end

# json.success true
# json.message 'success'
# json.data do
#   json.array! @posts do |post|
#     json.id post.id
#     json.content post.content
#     json.user_id post.user_id
#     json.user_name post.user.username
#     json.like_num  post.count_like
#     json.comments do
#       json.array! post.comments do |comment|
#         json.id comment.id
#         json.comment_text comment.comment_text
#         json.user_id comment.user_id
#         json.user_name comment.user.username
#       end
#     end
#   end
# end
