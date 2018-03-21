json.extract! article_comment, :id, :author_id, :comment, :article_id, :community_id, :created_at, :updated_at
json.url article_comment_url(article_comment, format: :json)
