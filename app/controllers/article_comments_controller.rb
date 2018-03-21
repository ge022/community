class ArticleCommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_community
  before_action :verify_access
  before_action :set_article
  before_action :verify_member
  before_action :find_commentable, only: [:create]
  before_action :set_member, only: :create
  before_action :set_article_comment, only: [:show, :edit, :update, :destroy]
  before_action :verify_author, only: [:edit, :update, :destroy]


  def index
    @article_comments = ArticleComment.all
  end

  def show
  end

  def new
    @article_comment = ArticleComment.new
  end

  def edit
  end

  def create
    @article_comment = @commentable.article_comments.new(attributes: article_comment_params)
    @article_comment.community = @community
    @article_comment.author_id = current_user.id
    @article_comment.user = current_user


    respond_to do |format|
      if @article_comment.save

        # Send mail to OP
        # Respondent member
        @responding_member = @member

        # Responding about this post
        # "@respondent.display_name replied to your post about @responding_about.post.truncate(30)"
        # "with: '@forum_reply.post.truncate(100)'"
        @responding_about = @commentable

        # Responding to
        @responding_to_user = @responding_about.user
        @responding_to_member = @community.members.find_by(user_id: @responding_to_user.id)

        if @responding_to_user != current_user
          ArticleCommentsMailer.article_notify_of_reply(@responding_member, @responding_about, @article_comment, @responding_to_user, @responding_to_member, @community, @article).deliver_later
        end

        format.html {redirect_to community_article_path(@community, @article), notice: 'Replied successfully.'}
        format.json {render :show, status: :created, location: @article_comment}
      else
        format.html {redirect_to community_article_path(@community, @article), notice: 'Failed to reply.'}
        format.json {render json: @article_comment.errors, status: :unprocessable_entity}
      end
    end
  end

  def update
    respond_to do |format|
      if @article_comment.update(article_comment_params)
        format.html {redirect_to community_article_path(@community, @article), notice: 'Your reply was updated.'}
        format.json {render :show, status: :ok, location: @article_comment}
      else
        format.html {render :edit}
        format.json {render json: @article_comment.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @article_comment.destroy
    respond_to do |format|
      format.html {redirect_to community_article_path(@community, @article), notice: 'Your reply was deleted.'}
      format.json {head :no_content}
    end
  end

  private
  def set_community
    @community = Community.find(params[:community_id])
  end

  def set_article
    @article = @community.articles.find(params[:article_id])
  end

  def verify_member
    redirect_to community_article_path(@community, @article), notice: "You're not allowed to do that." if !user_is_member?(@community)
  end

  def set_member
    @member = @community.members.find_by(user: current_user)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_article_comment
    @article_comment = ArticleComment.find(params[:id])
  end

  def find_commentable
    @commentable = Article.find(params[:article_id]) if params[:article_id]
    @commentable = ArticleComment.find(params[:article_comment_id]) if params[:article_comment_id]
  end

  def verify_author
    redirect_to community_article_path(@community, @article), notice: "You're not allowed to do that." if !user_is_author? @article_comment
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_comment_params
    params.require(:article_comment).permit(:article_id, :community_id, :comment, :author_id)
  end
end