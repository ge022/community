class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true, with: :exception

  around_action :user_time_zone, if: :current_user

  helper_method :user_is_admin?
  helper_method :user_is_member?
  helper_method :user_is_author?
  helper_method :verify_access

  def user_is_admin?(community)
    if user_signed_in?
      return community.members.where(role: 'admin').exists?(user_id: current_user.id)
    end
  end

  def user_is_member?(community)
    return user_signed_in? ? community.members.exists?(user: current_user) : false
  end

  def user_is_author?(post)
    return user_signed_in? ? user_is_member?(@community) && (post.user == current_user) || user_is_admin?(@community) : false
  end

  def verify_access
    if @community.try(:private)
      # Require authentication for accessing a private community
      if !user_signed_in?
        # Prompt visitor to sign in
        redirect_to new_user_session_path
      elsif user_signed_in? && !@community.members.exists?(user_id: current_user.id)
        # Current user is not a member of the private community
        redirect_to communities_path, notice: 'You do not have access to that community.'
      end
    end
  end

  private

  def user_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end

end
