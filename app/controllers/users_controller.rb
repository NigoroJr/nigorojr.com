class UsersController < ApplicationController
  def show
    # First attempts to find articles posted by user with given screen name
    @user = User.find_by_screen(params[:screen])
    if @user.present?
      @articles = Article.find_all_by_author_username(@user.username)
    else
      # If given screen name was not found, assume given param is username
      @articles = Article.find_all_by_author_username(params[:screen].downcase)
    end
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
    # TODO
  end

  def update
    # TODO
  end

  def destroy
    @user = find(params[:id])
    @user.destroy

    redirect_to "root", notice: "Deleted user"
  end
end
