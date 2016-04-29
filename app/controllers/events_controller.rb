class EventsController < ApplicationController
  before_action :denide_access_if_user_unsigned_in,        only: [:update, :destroy, :edit, :new, :create]
  before_action :set_event,                                only: [:update, :destroy, :edit, :show]
  before_action :denide_access_if_user_has_no_permissions, only: [:update, :destroy, :edit]

  def index
    if params[:mine].nil?
      @events = Event.all.order(:date)
    else
      @events = current_user.events
    end
    @date = params[:date].nil? ? Date.today : Date.strptime(params[:date], '%Y-%m')
    render :usual unless params[:usual].nil?
  end

  def show
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
    params.require(:event).permit(:name, :date, :description).merge(user: current_user).merge(date: Date.strptime(params[:event][:date], '%m/%d/%Y')) if params[:event]
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
