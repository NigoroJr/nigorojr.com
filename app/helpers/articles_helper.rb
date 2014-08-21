module ArticlesHelper
  # Gets the screen name from the given username.
  # Returns the given username if it can't find corresponding screen name.
  def get_author_screen(posted_by)
    user = User.find_by_username(posted_by)

    if user.present?
      return user.screen
    else
      return posted_by
    end
  end

  def is_viewable(article)
    # Owner or root can view draft
    if @logged_in_as && @logged_in_as.can_modify(article)
      return true
    end

    return !article.is_draft
  end
end
