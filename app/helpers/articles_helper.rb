module ArticlesHelper
  def convert_to_markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, extensions = {
      fenced_code_blocks: true,
      tables: true,
      strikethrough: true,
      autolink: true,
    })
    return markdown.render(text);
  end

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
end
