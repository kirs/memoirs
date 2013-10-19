class RubyGemSerializer < ActiveModel::Serializer
  attributes :id, :name, :latest_version

  has_many :versions, embed: :objects
end
