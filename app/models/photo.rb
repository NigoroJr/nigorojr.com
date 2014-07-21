class Photo < ActiveRecord::Base
  def get_thumbnail_path
    return self.file_path.sub(/(?=\.[^.]*$)/, "_thumb")
  end
end
