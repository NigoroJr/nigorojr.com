class SessionsController < ApplicationController
  def create
    user = User.authenticate(params[:username], params[:password])

    if user
      session[:user_id] = user.id
    else
      flash.alert = "Incorrect combination of username and password"
    end
    redirect_to params[:from] || :root
  end

  def destroy
    session.delete(:user_id)
    redirect_to :root
  end
end
