class ForumsController < ApplicationController
  before_action :set_community

  before_action :authenticate_user!, except: [:index, :show]
  before_action :verify_access
  before_action :verify_member, except: [:index, :show]

  before_action :set_forum, only: [:show, :edit, :update, :destroy]
  before_action :verify_author, only: [:edit, :update, :destroy]
  before_action :set_replies, only: :show

  # GET /forums
  # GET /forums.json

  def index
    @forums = @community.forums.all
  end

  # GET /forums/1
  # GET /forums/1.json
  def show
  end

  # GET /forums/new
  def new
    @forum = Forum.new
  end

  # GET /forums/1/edit
  def edit
  end

  # POST /forums
  # POST /forums.json
  def create
    @forum = Forum.new(attributes: forum_params, user: current_user, community: @community)

    respond_to do |format|
      if @forum.save
        format.html {redirect_to community_forum_path(@community, @forum), notice: 'Post was successfully created.'}
        format.json {render :show, status: :created, location: @forum}
      else
        format.html {render :new}
        format.json {render json: @forum.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /forums/1
  # PATCH/PUT /forums/1.json
  def update
    respond_to do |format|
      if @forum.update(forum_params)
        format.html {redirect_to community_forums_path, notice: 'Post was successfully updated.'}
        format.json {render :show, status: :ok, location: @forum}
      else
        format.html {render :edit}
        format.json {render json: @forum.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /forums/1
  # DELETE /forums/1.json
  def destroy
    @forum.destroy
    respond_to do |format|
      format.html {redirect_to community_forums_path, notice: 'Post was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private
  def set_replies
    @replies = @forum.forum_replies
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_forum
    @forum = Forum.find(params[:id])
  end

  def set_community
    @community = Community.find(params[:community_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def forum_params
    params.require(:forum).permit(:community_id, :title, :post)
  end

  def verify_member
    redirect_to @community, notice: "You're not allowed to do that." if !user_is_member?(@community)
  end

  def verify_author
    redirect_to @community, notice: "You're not allowed to do that." if !user_is_author? @forum
  end

end