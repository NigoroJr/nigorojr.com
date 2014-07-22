module ApplicationHelper
  def get_title
    website_title = "NigoroJr"

    website_title = @page_title + " - " + website_title if @page_title

    return website_title
  end

  def get_login_status
    name = sprintf "%s (%s)", @logged_in_as.screen, @logged_in_as.username
  end
end
