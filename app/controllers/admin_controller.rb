class AdminController < ApplicationController
  def index
    @is_root = @logged_in_as.username == UsersController::ROOT
    @articles = @is_root ? Article.all : Article.where(posted_by: @logged_in_as.username)
    @articles.order!("created_at DESC")

    @products = @is_root ? Product.all : Product.where(posted_by: @logged_in_as.username)
    @products.order!("created_at DESC")

    @photos = @is_root ? Photo.all : Photo.where(posted_by: @logged_in_as.username)
    @photos.order!("created_at DESC")
  end
end
