class UsersController < ApplicationController
  def show
    respond_with user
  end

  def index
    respond_with users, serialize: PageSerializer
  end

  def create
    user = User.create_with_omniauth(request.env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to "/#{user.friendly_id}"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  def update
    respond_with user.update(user_params)
  end

  protected

  def users
    User.search(search_params).page(page).per(per).records
  end

  def page
    params[:page] || 1
  end

  def per
    params[:per] || 12
  end

  def user
    (params[:id] ? User.friendly.find(params[:id]) : current_user).tap do |user|
      authorize user
    end
  end

  def search_params
    { query: { fuzzy: { name: params[:query] } } }
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
