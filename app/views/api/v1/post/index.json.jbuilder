json.success true
json.message "success"
json.data  do
    json.array! @posts do |post|
        json.partial! "post_details" , post: post
    end
end