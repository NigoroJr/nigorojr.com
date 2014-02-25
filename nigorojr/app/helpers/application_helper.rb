module ApplicationHelper
  def get_title
    page_title = "NigoroJr"

    page_title = @title + " - " + page_title if @title

    return page_title
  end
end
