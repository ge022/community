module ArticleCommentsHelper
  def article_reply_is_nested?(reply)
    return reply.article_commentable_type === 'ArticleComment'
  end

end
