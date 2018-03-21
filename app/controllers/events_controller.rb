class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:calendar, :index, :show]

  before_action :set_community
  before_action :verify_access
  before_action :verify_member, except: [:index, :show]

  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :set_beginning_of_week
  before_action :verify_author, only: [:edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.where('end_time >= ?', Time.zone.now)
  end

  def calendar
    @events = Event.where('end_time >= ?', Time.zone.now)
  end

  def manage
    @events = Event.where(user: current_user)
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(attributes: event_params, user: current_user, community: @community)

    respond_to do |format|
      if @event.save
        format.html {redirect_to community_event_path(@community, @event), notice: 'Event was successfully created.'}
        format.json {render :show, status: :created, location: community_event_path(@community, @event)}
      else
        format.html {render :new}
        format.json {render json: @event.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html {redirect_to community_events_manage_path, notice: 'Event was successfully updated.'}
        format.json {render :show, status: :ok, location: community_event_path(@community, @event)}
      else
        format.html {render :edit}
        format.json {render json: @event.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html {redirect_to community_events_manage_path, notice: 'Event was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  def set_community
    @community = Community.find(params[:community_id])
  end

  def set_event
    @event = Event.find(params[:id])
  end

  def set_beginning_of_week
    Date.beginning_of_week = :sunday
  end

  def verify_member
    redirect_to community_events_path, notice: "You're not allowed to do that." if !user_is_member?(@community)
  end

  def verify_author
    redirect_to community_events_path, notice: "You're not allowed to do that." if !user_is_author?(@event)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:title, :description, :start_time, :end_time)
  end
end
