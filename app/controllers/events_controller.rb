class EventsController < ApplicationController
  before_action :denide_access_if_user_unsigned_in,        only: [:update, :destroy, :edit, :new, :create]
  before_action :set_event,                                only: [:update, :destroy, :edit, :show]
  before_action :denide_access_if_user_has_no_permissions, only: [:update, :destroy, :edit]

  def index
    if params[:mine] and user_signed_in?
      @events = current_user.events
    else
      @events = Event.all.order(:date)
    end

    @date = EventService.parse_date(params[:date])

    render :usual if params[:usual]
  end

  def show
    @event.user = User.new email: 'deleted account' if @event.user.nil?
  end

  def new
    @event = Event.new event_params
    @event.date ||= Date.today
  end

  def edit
  end

  def create
    @event = Event.create(event_params)
    if @event.valid?
      redirect_to @event, notice: 'Successfully created!'
    else
      redirect_to new_event_path(event: @event), notice: 'There are errors!'
    end
  end

  def update
    if @event.update_attributes(event_params)
      redirect_to @event, notice: 'Successfully updated!'
    else
      redirect_to edit_event_path(@event), notice: 'There are errors!'
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path, notice: 'Successfully deleted!'
  end

private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params[:event] ? EventService.parse_params(params, current_user) : Hash.new
  end

  def denide_access_if_user_unsigned_in
    denide_access unless user_signed_in?
  end

  def denide_access_if_user_has_no_permissions
    denide_access unless @event.user == current_user
  end

  def denide_access
    redirect_to root_path, notice: 'Access Denided'
  end
end
