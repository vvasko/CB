module WelcomeHelper
  def current_table_id= table_id
    cookies.permanent[:table_id] = table_id
  end

  def current_table_id
    cookies[:table_id]
  end
end
