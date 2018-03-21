module ApplicationHelper

  # def user_is_author?(post)
  #   return user_signed_in? ? user_is_member?(@community) && (post.user == current_user) || user_is_admin?(@community) : false
  # end

  def member_display_name(post)
    display_name = post.user.members.find_by(community: @community).try(:display_name)
    return display_name ? display_name : '<i>deleted<i>'.html_safe
  end

  def comment_member_display_name(post)


    display_name = post.user.members.find_by(community: @community).try(:display_name)
    return display_name ? display_name : '<i>deleted<i>'.html_safe
  end

end
