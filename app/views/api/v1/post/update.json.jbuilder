json.success true
json.message "Update success"
json.data do 
    json.partial! "post_details", post: @post
end