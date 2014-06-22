require 'rubygems'
require 'RMagick'

module PhotosHelper
  def create_thumbnail(path)
    # Actual path on system
    real_path = File.realpath("./app/assets/images/") + "/"

    thumb = Magick::ImageList.new(real_path + path)

    # foo/bar.jpg becomes foo/bar_thumb.jpg
    thumb_path = path.sub(/(\..*?)$/, '_thumb\1')

    # width = thumb.columns * 0.1
    # height = thumb.rows * 0.1
    width = 198
    height = 108
    thumb.thumbnail(width, height).write(real_path + thumb_path)

    return thumb_path
  end

  def get_alt(photo)
    what = photo.object
    where = photo.location

    what.sub!(/;/, " and ")

    return what + " at " + where
  end
end
