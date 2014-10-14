class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar

  def id
    object.friendly_id
  end


  def avatar
    "http://placehold.it/50x50"
  end
end
