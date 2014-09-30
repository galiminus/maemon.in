class RelationshipSerializer < ActiveModel::Serializer
  attributes :created_at, :id

  def id
    object.followed.friendly_id
  end
end
