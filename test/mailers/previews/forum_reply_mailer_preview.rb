# Preview all emails at http://localhost:3000/rails/mailers/forum_reply_mailer
class ForumReplyMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/forum_reply_mailer/notify_of_reply
  def notify_of_reply
    ForumReplyMailer.notify_of_reply
  end

end
