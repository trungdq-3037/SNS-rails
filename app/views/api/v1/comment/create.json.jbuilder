json.success true
json.message 'Created successfully'
json.data do
  json.comment_text @comment.comment_text
  json.user_id @comment.user_id
  json.user_name @comment.user.username
  json.id @comment.id
end
