class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar

  def id
    object.friendly_id
  end

  def avatar
    if object.avatar
      Cloudinary::Utils.cloudinary_url object.avatar.path, width: 50, height: 50, crop: :fill
    end
  end
end
