json.array!(@authority_change_requests) do |authority_change_request|
  json.extract! authority_change_request, :id, :user_id, :src_authority, :dst_authority, :user_remark, :manager_remark, :status
  json.url authority_change_request_url(authority_change_request, format: :json)
end
