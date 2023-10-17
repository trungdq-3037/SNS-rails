json.id post.id
json.content post.content
json.user_id post.user_id
json.user_name post.user.username
# json.comments_count post.comments.count
json.count_like  post.count_like
json.count_comment  post.count_comment
json.current_user_liked post.current_user_liked
# json.count_comment post.comment_count
# json.count_like post.like_counts
json.comments do
  json.array! post.comments do |comment|
    json.id comment.id
    json.comment_text comment.comment_text
    json.user_id comment.user_id
    json.user_name comment.user.username
  end
end
