class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :avatar

  def avatar
    if object.avatar
      Cloudinary::Utils.cloudinary_url object.avatar.path, width: 50, height: 50, crop: :fill
    end
  end
end
