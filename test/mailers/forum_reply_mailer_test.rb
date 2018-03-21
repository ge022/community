require 'test_helper'

class ForumReplyMailerTest < ActionMailer::TestCase
  test "notify_of_reply" do
    mail = ForumReplyMailer.notify_of_reply
    assert_equal "Notify of reply", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
