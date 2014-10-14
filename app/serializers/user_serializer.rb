class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar

  def id
    object.friendly_id
  end


  def avatar
    object.avatar.url
  end
end
