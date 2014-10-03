class RelationshipPolicy < ApplicationPolicy
  def show?
    user.id == resource.user_id
  end

  def index?
    user.id == resource.user_id
  end

  def create?
    user.id == resource.user_id
  end

  def destroy?
    user.id == resource.user_id
  end
end
