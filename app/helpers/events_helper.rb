module EventsHelper
  def weekdays
    %w[Sunday Monady Tuesday Wednesday Thursday Friday Saturday].map { |w| "<p class=\"text-center\">#{w}</p>" }
  end

  def info_text text, condition
    text if condition == true
  end

  def events
    @all_events ||=
      if params[:mine]
        current_user.events
      else
        Event.all
      end
  end

  def get_events_for date
    day, weekday, month = date.day, date.wday, date.month

    [
      everyday_duplicating.to_a,
      everyweek_duplicating[weekday],
      everymonth_duplicating[day],
      (everyyear_duplicating[month] || [])[day]
    ]
    .map { |a| a || [] }.flatten
    .map { |e| link_to e.name, e }.join('<br />').html_safe
  end

  def everyday_duplicating
    @everyday_d ||= events.where(occurance: :d)
  end

  def everyweek_duplicating
    if @everyweek_d.nil?
      @everyweek_d = []
      events.where(occurance: :w)
        .map { |e|
          @everyweek_d[e.date.wday] ||= []
          @everyweek_d[e.date.wday] << e
        }
    end
    @everyweek_d
  end

  def everymonth_duplicating
    if @everymonth_d.nil?
      @everymonth_d = []
      events.where(occurance: :m)
        .map { |e|
          @everymonth_d[e.date.day] ||= []
          @everymonth_d[e.date.day] << e
        }
    end
    @everymonth_d
  end

  def everyyear_duplicating
    if @everyyear_d.nil?
      @everyyear_d = []
      events.where(occurance: :y)
        .map { |e|
          @everyyear_d[e.date.year] ||= []
          @everyyear_d[e.date.year][e.date.month] ||= []
          @everyyear_d[e.date.year][e.date.month] << e
        }
    end
    @everyyear_d
  end
end
