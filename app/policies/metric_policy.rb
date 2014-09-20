class MetricPolicy < ApplicationPolicy
  def show?
    true
  end

  def index?
    true
  end

  def create?
    user.id == resource.user_id
  end

  def update?
    user.id == resource.user_id
  end

  def destroy?
    user.id == resource.user_id
  end
end
