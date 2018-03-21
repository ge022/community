class ForumRepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_community
  before_action :verify_access
  before_action :set_forum
  before_action :verify_member
  before_action :find_commentable, only: [:create]
  before_action :set_member, only: :create
  before_action :set_forum_reply, only: [:show, :edit, :update, :destroy]
  before_action :verify_author, only: [:edit, :update, :destroy]

  # GET /forum_replies
  # GET /forum_replies.json
  def index
    @forum_replies = ForumReply.all
  end

  # GET /forum_replies/1
  # GET /forum_replies/1.json
  def show
  end

  # GET /forum_replies/new
  def new
    @forum_reply = ForumReply.new
  end

  # GET /forum_replies/1/edit
  def edit
  end

  # POST /forum_replies
  # POST /forum_replies.json
  def create
    @forum_reply = @commentable.forum_replies.new(attributes: forum_reply_params, user: current_user, community: @community)

    respond_to do |format|
      if @forum_reply.save

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
          ForumReplyMailer.notify_of_reply(@responding_member, @responding_about, @forum_reply, @responding_to_user, @responding_to_member, @community, @forum).deliver_later
        end

        format.html {redirect_to community_forum_path(@community, @forum), notice: 'Replied successfully.'}
        format.json {render :show, status: :created, location: @forum_reply}
      else
        format.html {redirect_to community_forum_path(@community, @forum), notice: 'Failed to reply.'}
        format.json {render json: @forum_reply.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /forum_replies/1
  # PATCH/PUT /forum_replies/1.json
  def update
    respond_to do |format|
      if @forum_reply.update(forum_reply_params)
        format.html {redirect_to community_forum_path(@community, @forum), notice: 'Your reply was updated.'}
        format.json {render :show, status: :ok, location: @forum_reply}
      else
        format.html {render :edit}
        format.json {render json: @forum_reply.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /forum_replies/1
  # DELETE /forum_replies/1.json
  def destroy
    @forum_reply.destroy
    respond_to do |format|
      format.html {redirect_to community_forum_path(@community, @forum), notice: 'Your reply was deleted.'}
      format.json {head :no_content}
    end
  end

  private
  def set_community
    @community = Community.find(params[:community_id])
  end

  def set_forum
    @forum = @community.forums.find(params[:forum_id])
  end

  def verify_member
    redirect_to community_forum_path(@community, @forum), notice: "You're not allowed to do that." if !user_is_member?(@community)
  end

  def set_member
    @member = @community.members.find_by(user: current_user)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_forum_reply
    @forum_reply = ForumReply.find(params[:id])
  end

  def find_commentable
    @commentable = Forum.find(params[:forum_id]) if params[:forum_id]
    @commentable = ForumReply.find(params[:forum_reply_id]) if params[:forum_reply_id]
  end

  def verify_author
    redirect_to community_forum_path(@community, @forum), notice: "You're not allowed to do that." if !user_is_author? @forum_reply
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def forum_reply_params
    params.require(:forum_reply).permit(:forum_id, :community_id, :post, :author_id)
  end
end
