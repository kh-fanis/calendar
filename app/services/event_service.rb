module EventService
  @@DATE_OUT_STYLE = '%Y-%m'    # when parsing params in caendar
  @@DATE_IN_STYLE  = '%m/%d/%Y' # when saving and updating the event

  # inned in a index page of events in calendar, to parse date from params
  def self.parse_date str
    Date.strptime(str, @@DATE_OUT_STYLE)
  rescue
    Date.today
  end

  # inned in a create and update actions of events controller to parse date and save to db
  def self.parse_params params, current_user
    set_up_params(params.require(:event).permit(:name, :date, :description), current_user)
  end

  def self.set_up_params params, current_user
    params.merge(user: current_user).merge(date: Date.strptime(params[:date], @@DATE_IN_STYLE))
  end
end