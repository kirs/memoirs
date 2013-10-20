class RubyGem < ActiveRecord::Base

  validates :name,
            presence:   true,
            uniqueness: true

  has_many :versions, dependent: :destroy

  extend FriendlyId
  friendly_id :name

  def latest_version
    versions.order("number DESC").first.try(:number)
  end
end
