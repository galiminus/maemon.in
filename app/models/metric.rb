class Metric < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :user

  validates :name, presence: true, length: { maximum: 140 }
  validates :value, inclusion: { in: 1..10 }

  def as_indexed_json(options={})
    self.as_json({
      only: [:name, :updated_at],
      include: { user: { only: [:friendly_id] } }
    })
  end
end
