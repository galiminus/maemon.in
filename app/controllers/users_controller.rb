class UsersController < ApplicationController
  def show
    respond_with user
  end

  def create
    user = User.create_with_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to "#/#{user.id}"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  def update
  end

  protected

  def user
    (params[:id] ? User.find(params[:id]) : current_user).tap do |user|
      authorize user
    end
  end
end
