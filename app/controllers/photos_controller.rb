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
    attributes = Photo.permit(:photo).require(:location, :object, :category, :file_path)
    @photo = Photo.new(attributes)

    if @photo.save
      redirect_to @photos
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
end
