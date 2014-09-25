class UsersController < ApplicationController
  def show
    respond_with user
  end

  def index
    respond_with User.search(search_params)
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
    respond_with user.update(user_params)
  end

  protected

  def user
    (params[:id] ? User.friendly.find(params[:id]) : current_user).tap do |user|
      authorize user
    end
  end

  def search_params
    params.require(:q)
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
