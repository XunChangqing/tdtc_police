json.array!(@password_reset_requests) do |password_reset_request|
  json.extract! password_reset_request, :id, :user_id, :remark, :status
  json.url password_reset_request_url(password_reset_request, format: :json)
end
