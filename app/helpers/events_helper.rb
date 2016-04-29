module EventsHelper
  def weekdays
    %w[Sunday Monady Tuesday Wednesday Thursday Friday Saturday].map { |w| "<p class=\"text-center\">#{w}</p>" }
  end
end
