module SkkdictEntriesHelper
  # Converts the tags separated by '\0' to a string
  # separated by commas for displaying in a table
  def separate_tags(tags)
    return tags.gsub("\0", ", ")
  end
end
