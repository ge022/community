class Communities::CommunityUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_community
  before_action :validate_join, only: [:new_join, :join] # Prevent re-joins
  before_action :verify_admin, only: [:index, :new_invite, :invite, :kick, :change_role, :role] # Only admins can invite
  before_action :validate_invite, only: [:invite] # Prevent duplicate invites
  before_action :set_community_user, only: [:edit, :update] # Update per-community preferences
  before_action :set_comm_user, only: [:change_role, :role] # Update per-community role
  before_action :set_num_admin, only: [:destroy, :kick, :change_role, :role]


  def index
    # List members of community
    # community_community_users_path(@community)
  end


  def edit
    # Edit per-community user preferences
    # community_user_preferences_path(@community)
  end

  def update
    # Form submission update member preferences
    if @community_user.update(community_user_params)
      redirect_to my_communities_path, notice: 'Preferences updated.'
    else
      redirect_to my_communities_path, notice: 'Could not update preferences.'
    end
  end


  def change_role
    # Edit per-community user role
  end

  def role
    @comm_user.role = params[:community_user][:role]
    if @num_admin <= 1 && @comm_user.id == current_user.members.find_by(community_id: @community.id).id && @comm_user.role == 'member'
      redirect_to community_users_path(@community.id), notice: "The community must have an admin."
    else
      # Form submission update member role
      if @comm_user.save
        redirect_to community_users_path(@community.id), notice: 'Member role updated.'
      else
        redirect_to community_users_path(@community.id), notice: 'Could not update member role.'
      end
    end
  end


  def new_join
    @community_user = @community.members.new
  end

  def join
    # Create a new CommunityUser
    community_user = @community.members.new(community_user_params)
    community_user.email = current_user.email
    if @community.adminID == current_user.id
      community_user.role = 'admin'
    else
      community_user.role = 'member'
    end
    community_user.community = @community
    if community_user.save
      redirect_to @community, notice: 'You have joined the community!'
    else
      redirect_to @community, notice: 'Failed to join community.'
    end
  end


  def new_invite
  end

  def invite
    # Create a new CommunityUser
    community_user = @community.members.new(community_user_invite_params)
    community_user.community = @community
    community_user.display_name = 'anonymous'
    if User.find_by(email: params[:member][:email]).try(:id) == @community.adminID
      community_user.role = 'admin'
    end
    if community_user.save
      redirect_to community_users_path, notice: 'User invited!'
    else
      redirect_to community_users_path, notice: 'Failed inviting user.'
    end
  end


  def destroy
    community_user = current_user.members.find_by(community_id: @community.id)
    if community_user.role == 'admin' && @num_admin <= 1
      if @community.members.count > 1
        redirect_to community_users_path(@community.id), notice: "The community must have an admin. Change another member's role to admin before leaving."
      else
        redirect_to my_communities_path, notice: "Leaving this community will delete it. To do so, please manually delete this community."
      end
    else
      if community_user.destroy
        # Member leaves community
        redirect_to my_communities_path, notice: "You have left " + @community.name + '.'
      else
        redirect_to my_communities_path, notice: "Failed to leave the community."
      end
    end
  end

  def kick
    community_user = @community.members.find_by(id: params[:id])
    if community_user.role == 'admin' && @num_admin <= 1
      if @community.members.count > 1
        redirect_to community_users_path, notice: "The community must have an admin. Change another member's role to admin before leaving."
      else
        redirect_to community_users_path, notice: "Leaving this community will delete it. To do so, please manually delete the community."
      end
    else
      if community_user.destroy
        # Member leaves community
        redirect_to community_users_path(@community.id), notice: "Member kicked."
      else
      redirect_to @community, notice: "Member could not be kicked."
      end
    end
  end


  private

  def set_community
    @community = Community.find(params[:community_id])
  end

  def set_community_user
    @community_user = current_user.members.find_by(community_id: @community.id)
    redirect_to my_communities_path, notice: 'Could not update preferences.' if @community_user.nil?
  end

  def validate_join
    redirect_to @community, notice: "You've already joined this community." if user_is_member?(@community)
  end

  def verify_admin
    redirect_to @community, notice: "You're not allowed to do that." if !user_is_admin?(@community)
  end

  def validate_invite
    redirect_to @community, notice: 'User already invited.' if @community.users.exists?(email: params[:member][:email])
  end


  def set_num_admin
    role_counts = @community.members.group(:role).count
    @num_admin = role_counts['admin']
  end

  def set_comm_user
    @comm_user = @community.members.find(params[:id])
    redirect_to my_communities_path, notice: 'Could not update preferences.' if @comm_user.nil?
  end


  def community_user_invite_params
    params.require(:member).permit(:email, :role)
  end

  def community_user_params
    params.require(:community_user).permit(:display_name, :role)
  end

end
