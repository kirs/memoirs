require 'spec_helper'

describe ReleaseNotesParser do
  it "can parse activerecord-stable" do
    filename = "activerecord-stable.md"
    content = open_changelog_fixture(filename)
    versions = described_class.parse(content, "md")

    expect(versions["3.2.15"]).to be_present
  end

  it "can parse activerecord" do
    filename = "activerecord.md"
    content = open_changelog_fixture(filename)
    versions = described_class.parse(content, "md")

    expect(versions["4.0.1.rc1"]).to be_present
  end

  def open_changelog_fixture(project)
    File.open(Rails.root.join("spec/fixtures", project)).read
  end
end
