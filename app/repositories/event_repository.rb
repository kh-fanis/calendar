module EventRepository
  @@DEFAULT_ORDER = :date

  def all *args
    super(*args).order(@@DEFAULT_ORDER)
  end
end