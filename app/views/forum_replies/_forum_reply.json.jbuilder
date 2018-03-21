json.extract! forum_reply, :id, :forum_id, :community_id, :post, :author_id, :created_at, :updated_at
json.url forum_reply_url(forum_reply, format: :json)
