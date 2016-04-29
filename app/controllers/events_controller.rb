class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @events = Event.all
  end

  def show
  end

  def new
    @event = Event.new event_params
  end

  def edit
  end

  def create
    @event = Event.create(event_params)
    if @event.valid?
      redirect_to @event, notice: 'Successfully created!'
    else
      redirect_to new_event_path(@event), notice: 'There are errors!'
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
    params.require(:event).permit(:name, :date, :description).merge(user: current_user) if params[:name]
  end
end
