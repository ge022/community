json.extract! forum, :id, :community_id, :author_id, :title, :post, :created_at, :updated_at
json.url forum_url(forum, format: :json)
