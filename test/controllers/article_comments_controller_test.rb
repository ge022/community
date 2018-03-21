require 'test_helper'

class ArticleCommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article_comment = article_comments(:one)
  end

  test "should get index" do
    get article_comments_url
    assert_response :success
  end

  test "should get new" do
    get new_article_comment_url
    assert_response :success
  end

  test "should create article_comment" do
    assert_difference('ArticleComment.count') do
      post article_comments_url, params: { article_comment: { article_id: @article_comment.article_id, author_id: @article_comment.author_id, comment: @article_comment.comment, community_id: @article_comment.community_id } }
    end

    assert_redirected_to article_comment_url(ArticleComment.last)
  end

  test "should show article_comment" do
    get article_comment_url(@article_comment)
    assert_response :success
  end

  test "should get edit" do
    get edit_article_comment_url(@article_comment)
    assert_response :success
  end

  test "should update article_comment" do
    patch article_comment_url(@article_comment), params: { article_comment: { article_id: @article_comment.article_id, author_id: @article_comment.author_id, comment: @article_comment.comment, community_id: @article_comment.community_id } }
    assert_redirected_to article_comment_url(@article_comment)
  end

  test "should destroy article_comment" do
    assert_difference('ArticleComment.count', -1) do
      delete article_comment_url(@article_comment)
    end

    assert_redirected_to article_comments_url
  end
end
