class ForumReplyMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.forum_reply_mailer.notify_of_reply.subject
  #
  def notify_of_reply(responding_member, responding_about, responding_with ,responding_to_user, responding_to_member, community, forum)
    @responding_member = responding_member.display_name
    @about = responding_about.post.truncate(30)
    @responding_with = responding_with
    @responding_to_member = responding_to_member
    @community = community
    @forum = forum

    mail to: responding_to_user.email,
         from: 'no-reply@rubyrebels.azurewebsites.net',
         bcc: '23706821+ge022@users.noreply.github.com',
         subject: @responding_to_member.display_name + ', ' + @responding_member + ' replied to you on the \'' + @community.name + '\' forum.'
  end
end
