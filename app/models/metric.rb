class Metric < ActiveRecord::Base
  belongs_to :user

  validates :name, presence: true, length: { maximum: 140 }
  validates :value, inclusion: { in: 1..10 }
end
