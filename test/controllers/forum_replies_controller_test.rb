require 'test_helper'

class ForumRepliesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @forum_reply = forum_replies(:one)
  end

  test "should get index" do
    get forum_replies_url
    assert_response :success
  end

  test "should get new" do
    get new_forum_reply_url
    assert_response :success
  end

  test "should create forum_reply" do
    assert_difference('ForumReply.count') do
      post forum_replies_url, params: { forum_reply: { author_id: @forum_reply.author_id, community_id: @forum_reply.community_id, forum_id: @forum_reply.forum_id, post: @forum_reply.post } }
    end

    assert_redirected_to forum_reply_url(ForumReply.last)
  end

  test "should show forum_reply" do
    get forum_reply_url(@forum_reply)
    assert_response :success
  end

  test "should get edit" do
    get edit_forum_reply_url(@forum_reply)
    assert_response :success
  end

  test "should update forum_reply" do
    patch forum_reply_url(@forum_reply), params: { forum_reply: { author_id: @forum_reply.author_id, community_id: @forum_reply.community_id, forum_id: @forum_reply.forum_id, post: @forum_reply.post } }
    assert_redirected_to forum_reply_url(@forum_reply)
  end

  test "should destroy forum_reply" do
    assert_difference('ForumReply.count', -1) do
      delete forum_reply_url(@forum_reply)
    end

    assert_redirected_to forum_replies_url
  end
end
