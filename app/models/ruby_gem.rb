class RubyGem < ActiveRecord::Base

  validates :name,
            presence:   true,
            uniqueness: true

  has_many :versions, dependent: :destroy

  extend FriendlyId
  friendly_id :name

end
