module ApplicationHelper
  def current_user
    @current_user
  end

  def human_readable_date(date)
    date.strftime("%m/%d/%Y %H:%M:%S")
  end
end
