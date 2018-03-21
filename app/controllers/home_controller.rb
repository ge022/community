class HomeController < ApplicationController
  before_action :authenticate_user!, only: :my_communities

  # GET /communities
  # GET /communities.json
  def index
  end

  def my_communities
    @my_communities = current_user.communities.where('role = ?', 'admin').references(:members)
    @member_communities = current_user.communities.where('role in (?)', ['member', 'admin']).references(:members)
  end

end
