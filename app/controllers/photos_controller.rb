class PhotosController < ApplicationController
  before_filter :login_required, :except => [:index, :show]

  # PARENT_PATH + photo.file_path becomes the absolute path of the image
  PARENT_PATH = sprintf "%s/app/assets/images/", Rails.root

  def index
    @photos = Photo.all
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def new
    @photo = Photo.new
  end

  def create
    attributes = params.require(:photo).permit(:location, :object, :category)
    @photo = Photo.new(attributes)

    object = params[:photo][:object]
    location = params[:photo][:location]

    # Build file path
    file_path = get_image_path(object, location, "jpg")

    # Write recieved binary data to file
    image_binary = params[:photo][:image_data].read
    absolute_path_orig = sprintf "%s/%s", PARENT_PATH, file_path
    File.open(absolute_path_orig, "wb").write(image_binary)
    create_thumbnail_of(absolute_path_orig)

    # file_path needs to be a relative path from app/assets/images/
    @photo.file_path = file_path

    if @photo.save
      index
      redirect_to "/gallery"
    else
      render "new"
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def destroy
    @photo = Photo.find(params[:id])
    begin
      # Remove image file
      absolute_path_orig = sprintf "%s/%s", PARENT_PATH, @photo.file_path
      File.delete(absolute_path_orig)

      # Remove thumbnail file
      absolute_path_thumb = sprintf "%s/%s",
        PARENT_PATH, @photo.get_thumbnail_path()
      File.delete(absolute_path_thumb)
    rescue  # In case file does not exist
      ""
    end

    @photo.destroy

    redirect_to "/gallery"
  end

  def update
    @photo = Photo.find(params[:id])
    attributes = params.require(:photo).permit(:location, :object, :category)

    # Update object and location
    @photo.object = params[:photo][:object]
    @photo.location = params[:photo][:location]

    # File path of existing image file
    old_path_orig = @photo.file_path

    # Get new file path
    file_path = get_image_path(@photo.object, @photo.location, "jpg")
    @photo.file_path = file_path
    absolute_path_orig = sprintf "%s/%s", PARENT_PATH, file_path

    # Write recieved binary data to file
    f = params[:photo][:image_data]
    if f != nil   # Image was updated
      # Updated image file
      image_binary = f.read
      File.open(absolute_path_orig, "wb").write(image_binary)

      # Also update thumbnail
      create_thumbnail_of(absolute_path_orig)
    else  # Changed object and/or location but not the image file
      old_absolute_path_orig = sprintf "%s/%s", PARENT_PATH, old_path_orig
      File.rename(old_absolute_path_orig, absolute_path_orig)

      # Rename thumbnail
      old_absolute_path_thumb = get_thumbnail_path_from(old_absolute_path_orig)
      absolute_path_thumb = get_thumbnail_path_from(absolute_path_orig)
      File.rename(old_absolute_path_thumb, absolute_path_thumb)
    end

    if @photo.save
      index
      redirect_to "/gallery"
    else
      render "edit"
    end
  end

  private
  # Builds a valid file name from the given information
  # Returns the RELATIVE PATH of the image file from app/assets/images/
  # Note that this method does NOT return just the file name
  def get_image_path(object, location, extension)
    # Relative path of parent directory based on app/assets/images/
    partial_path = "GT6"

    # File name: CAR_CIRCUIT_ID.EXTENSION
    # Increments the ID if file already exists
    index = 0
    begin
      file_name = sprintf "%s_%s_%03d.%s",
        object.downcase, location.downcase, index, extension
      file_path = sprintf "%s/%s", partial_path, file_name
      absolute_path = sprintf "%s/%s", PARENT_PATH, file_path

      index += 1
    end while File.exists?(absolute_path)

    return file_path
  end

  # Creates a thumbnail of the given original image file
  def create_thumbnail_of(absolute_path_orig)
    thumb = Magick::ImageList.new(absolute_path_orig)

    absolute_path_thumb = get_thumbnail_path_from(absolute_path_orig)

    # width = thumb.columns * 0.1
    # height = thumb.rows * 0.1
    width = 198
    height = 108
    thumb.thumbnail(width, height).write(absolute_path_thumb)
  end

  # Returns the path (or file name) of the thumbnail from the original path.
  # Argument can be either an absolute or relative path.
  def get_thumbnail_path_from(path_orig)
    return path_orig.sub(/(?=\.[^.]*$)/, "_thumb")
  end
end
