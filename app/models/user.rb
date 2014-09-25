class User < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name

  has_many :metrics
  has_attachment  :avatar, accept: [:jpg, :png, :gif]

  def self.create_with_omniauth(auth)
    User.find_or_initialize_by(email: auth["info"]["email"]).tap do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.avatar_url = auth["info"]["image"]

      user.save!
    end
  end
end
