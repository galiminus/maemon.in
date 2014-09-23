class UserPolicy < ApplicationPolicy
  def show?
    true
  end

  def update?
    user.id == resource.id
  end
end
