require 'rubygems'
require 'RMagick'

module PhotosHelper
  def get_alt(photo)
    what = photo.object
    where = photo.location

    what.sub!(/;/, " and ")

    return what + " at " + where
  end
end
