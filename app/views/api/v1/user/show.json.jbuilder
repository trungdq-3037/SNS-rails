json.success true
json.message 'success'
json.data do
  json.username @current_user.username
  json.email @current_user.email
  json.id @current_user.id
end
