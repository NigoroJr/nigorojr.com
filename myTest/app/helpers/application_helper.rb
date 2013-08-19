module ApplicationHelper
  def page_title
    str = "Morning Glory (MyTest)"
    @page_title ? @page_title + "::" + str : str
  end

  def menu_link_to(text, path)
    link_to_unless_current(text, path) {
      content_tag(:span, text)
    }
  end
end
