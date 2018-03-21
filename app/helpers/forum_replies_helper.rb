module ForumRepliesHelper

  def reply_is_nested?(reply)
    return reply.forum_commentable_type === 'ForumReply'
  end

end
