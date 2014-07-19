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
end
