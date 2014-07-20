class PhotosController < ApplicationController
  before_filter :login_required, :except => [:index, :show]

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

    # Relative path of parent directory based on app/assets/images/
    partial_path = "GT6"
    # Write in RAILS_ROOT/app/assets/images/GT6
    parent_dir = sprintf "%s/app/assets/images/%s", Rails.root, partial_path
    # Build file name
    file_name = get_image_file_name(parent_dir, object, location, "jpg")

    # Write recieved binary data to file
    image_binary = params[:photo][:image_data].read
    file_path = sprintf "%s/%s", parent_dir, file_name
    File.open(file_path, "wb").write(image_binary)

    # file_path needs to be a relative path from app/assets/images/
    @photo.file_path = sprintf "%s/%s", partial_path, file_name

    if @photo.save
      index
      redirect_to "/gallery"
    else
      render "new"
    end
  end

  def edit
  end

  def destroy
  end

  def update
  end

  private
  # Builds a valid file name from the given information
  def get_image_file_name(parent_dir, object, location, extension)
    index = 0
    begin
      file_name = sprintf "%s_%s_%03d.%s",
        object.downcase.sub(" ", "-"),
        location.downcase.sub(" ", "-"), index, extension
      full_path = sprintf "%s/%s", parent_dir, file_name
      index += 1
    end while File.exists?(full_path)

    return file_name
  end
end
