class User < ActiveRecord::Base
  has_many :metrics

  def self.create_with_omniauth(auth)
    User.find_or_initialize_by(email: auth["info"]["email"]).tap do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]

      user.save!
    end
  end
end
