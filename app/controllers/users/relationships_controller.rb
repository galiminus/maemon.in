class Users::RelationshipsController < ApplicationController
  def show
    respond_with relationship
  end

  def index
    respond_with user.followed
  end

  def create
    followed = User.friendly.find relationship_params[:id]
    relationship = Relationship.new(user: user, followed: followed)

    authorize relationship

    respond_with user.relationships.create(relationship.attributes)
  end

  def destroy
    respond_with relationship.delete
  end

  protected

  def user
    User.friendly.find params[:user_id]
  end

  def followed
    User.friendly.find params[:id]
  end

  def relationship
    User::Relationship.find_by_user_id_and_followed_id!(user.id, followed.id).tap do |relationship|
      authorize relationship if relationship
    end
  end

  def relationship_params
    params.require(:relationship).permit(:id)
  end

  def relationship_url(relationship)
    user_relationship_path(user, relationship)
  end
end
