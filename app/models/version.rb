class Version < ActiveRecord::Base

  validates :number,
            presence:   true,
            uniqueness: { scope: :ruby_gem_id }

  belongs_to :ruby_gem

  before_save :split_out_version_number

  private

  def split_out_version_number
    if number_changed?
      self.major, self.minor, self.patch =
        Gem::Version.new(number).release.segments
    end
  end

end
