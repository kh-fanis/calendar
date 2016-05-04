module EventsHelper
  def weekdays
    %w[Sunday Monady Tuesday Wednesday Thursday Friday Saturday].map { |w| "<p class=\"text-center\">#{w}</p>" }
  end

  def info_text text, condition
    text if condition == true
  end
end
