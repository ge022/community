class CommunitiesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_community, only: [:show, :edit, :update, :destroy]
  before_action :verify_access
  before_action :verify_admin, only: [:edit, :update, :destroy]

  # GET /communities
  # GET /communities.json
  def index
    # @communities = Community.all
    @communities = Community.where(private: false)
  end

  # GET /communities/1
  # GET /communities/1.json
  def show
    # @members = Member.where(community_id: @community.id)

  end

  # def is_member?
  #   @members.detect{ | v | v.user_id == current_user.id}
  # end
  # helper_method 'is_member?'

  # def get_memberID
  #   obj = @members.detect{ | v | v.user_id == current_user.id }
  #
  #   obj.id
  # end
  # helper_method 'get_memberID'

  # GET /communities/new
  def new
    @community = Community.new
  end


  # GET /communities/1/edit
  def edit
  end

  # POST /communities
  # POST /communities.json
  def create
    @community = Community.new(community_params)
    # Add community admin as a member
    # If admin leaves a community, they no longer have access to edit, even after rejoining
    @community.members.build(user: current_user, role: 'admin', email: current_user.email,
                                     display_name: params[:member][:user_display_name])
    @community.adminID = current_user.id

    respond_to do |format|
      if @community.save
        format.html {redirect_to @community, notice: 'Community was successfully created.'}
        format.json {render :show, status: :created, location: @community}
      else
        format.html {render :new}
        format.json {render json: @community.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /communities/1
  # PATCH/PUT /communities/1.json
  def update
    respond_to do |format|
      # Update admin's display name
      if @community.update(community_params)
        current_user.save
        format.html { redirect_to my_communities_path, notice: 'Community was successfully updated.' }
        format.json { render :show, status: :ok, location: @community }
      else
        format.html {render :edit}
        format.json {render json: @community.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /communities/1
  # DELETE /communities/1.json
  def destroy
    @community.destroy
    respond_to do |format|
      format.html { redirect_to my_communities_path, notice: 'Community was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_community
    @community = Community.find(params[:id])
  end

  def verify_admin
    # Redirect if the user is not an admin of the community
    redirect_to communities_path, notice: 'You do not have permission to edit that community.' if !user_is_admin?(@community)
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def community_params
    params.require(:community).permit(:name, :description, :promo, :private, :user_display_name)
  end

end
