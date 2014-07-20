class UsersController < ApplicationController
  def show
    @user = User.find_by_screen(params[:screen])
    if @user.present?
      @articles = Article.find_all_by_author_username(@user.username)
    end
  end

  def new
    @user = User.new
  end

  def create
    attributes = params.require(:user).permit(:screen, :username, :raw_password, :raw_password_confirmation)
    @user = User.new(attributes)
    @user.hashed_password = BCrypt::Password.create(params[:user][:raw_password])

    if @user.save
      redirect_to :root, notice: "Created user"
    else
      flash.notice = "Try a different username"
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
