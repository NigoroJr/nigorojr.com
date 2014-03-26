module ApplicationHelper
  def get_title
    website_title = "NigoroJr"

    website_title = @page_title + " - " + website_title if @page_title

    return website_title
  end
end
