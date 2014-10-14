class User < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  has_many :metrics
  has_attached_file :avatar
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  has_many :relationships
  has_many :followed, :through => :relationships

  def self.create_with_omniauth(auth)
    User.find_or_initialize_by(email: auth["info"]["email"]).tap do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.avatar = auth["info"]["image"]

      user.save!
    end
  end

  def should_generate_new_friendly_id?
    name_changed? || super
  end
end
