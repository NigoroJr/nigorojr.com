class UsersController < ApplicationController
  ROOT = "root"
  ARTICLES_LIMIT = 5
  PRODUCTS_LIMIT = 10
  PHOTOS_LIMIT = 20

  def show
    # First attempts to find articles posted by user with given screen name
    @user = User.find_by_screen(params[:screen])
    if @user.present?
      @articles = Article.where(posted_by: @user.username)
      @products = Product.where(posted_by: @user.username)
      @photos = Photo.where(posted_by: @user.username)
    else
      # If given screen name was not found, assume given param is username
      username = params[:screen].downcase
      @articles = Article.where(posted_by: username)
      @products = Product.where(posted_by: username)
      @photos = Photo.where(posted_by: username)
    end

    @articles.limit(ARTICLES_LIMIT)
    @products.limit(PRODUCTS_LIMIT)
    @photos.limit(PHOTOS_LIMIT)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new
    @user.screen = params[:user][:screen]
    @user.username = params[:user][:username].downcase
    @user.hashed_password = BCrypt::Password.create(params[:user][:raw_password])

    if @user.save
      redirect_to :root, notice: "Created user"
    else
      password = params[:user][:raw_password]
      password_confirmation = params[:user][:raw_password_confirmation]

      if password.empty? || password_confirmation.empty?
        flash.notice = "Enter both password and confirmation"
      elsif password != password_confirmation
        flash.notice = "Confirmation doesn't match"
      else
        flash.notice = "Try a different username"
      end

      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])

    if !@logged_in_as.can_modify(@user)
      raise Forbidden
    end
  end

  def update
    # Use currently logged in user's username
    @user = User.find_by_username(@logged_in_as.username)

    # Update "posted_by"s if username was changed
    old_username = @user.username
    new_username = params[:user][:username].downcase
    if new_username != old_username
      update_posted_by(old_username, new_username)
    end

    # Update user information
    @user.username = new_username
    @user.screen = params[:user][:screen]

    password = params[:user][:raw_password]
    password_confirmation = params[:user][:raw_password_confirmation]
    if !password.empty?
      @user.hashed_password = BCrypt::Password.create(params[:user][:raw_password])
    end

    if @user.save
      # Update currently
      @logged_in_as = @user
      redirect_to :root, notice: "Updated user information"
    else
      if password != password_confirmation
        flash.notice = "Confirmation doesn't match"
      else
        flash.notice = "Try a different username"
      end

      render "new"
    end
  end

  def destroy
    @user = find(params[:id])

    if !@logged_in_as.can_modify(@user)
      raise Forbidden
    end

    @user.destroy

    redirect_to "root", notice: "Deleted user"
  end

  private
  # Updates the "posted_by" fields to the new username
  def update_posted_by(old_username, new_username)
    models = [Article, Product, Photo]

    models.each do |model|
      posts = model.where(posted_by: old_username)

      posts.each do |post|
        post.posted_by = new_username
        post.save
      end
    end
  end
end
