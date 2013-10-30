require 'spec_helper'

describe ReleaseNotesParser do
  context "activerecord-stable" do
    it "can be parsed" do
      filename = "activerecord-stable.md"
      content = open_changelog_fixture(filename)
      versions = described_class.parse(content, "md")

      expect(versions["3.2.15"]).to be_present
    end
  end

  context "capistrano" do
    it "can be parsed" do
      filename = "capistrano.md"
      content = open_changelog_fixture(filename)
      versions = described_class.parse(content, "md")

      # TODO check version
    end
  end

  context "ancestry" do
    it "can be parsed" do
      filename = "ancestry.md"
      content = open_changelog_fixture(filename)
      versions = described_class.parse(content, "md")

      # TODO check version
    end
  end

  context "sidekiq" do
    it "can be parsed" do
      filename = "sidekiq.md"
      content = open_changelog_fixture(filename)
      versions = described_class.parse(content, "md")

      # TODO check version
    end
  end

  context "thor" do
    it "can be parsed" do
      filename = "thor.md"
      content = open_changelog_fixture(filename)
      versions = described_class.parse(content, "md")

      # TODO check version
    end
  end

  context "activerecord" do
    it "can be parsed" do
      filename = "activerecord.md"
      content = open_changelog_fixture(filename)
      versions = described_class.parse(content, "md")

      expect(versions["4.0.1.rc1"]).to be_present
    end
  end

  context "kaminari" do
    it "can be parsed" do
      filename = "kaminari.md"
      content = open_changelog_fixture(filename)
      versions = described_class.parse(content, "md")

      expect(versions["0.14.1"]).to be_present
    end
  end

  context "devise" do
    it "can be parsed" do
      filename = "devise.md"
      content = open_changelog_fixture(filename)
      versions = described_class.parse(content, "md")

      expect(versions["3.1.1"]).to be_present
      # also with -dev suffix
      expect(versions["3.2.0-dev"]).to be_present
    end
  end

  context "enumerize" do
    it "can be parsed" do
      filename = "enumerize.md"
      content = open_changelog_fixture(filename)
      versions = described_class.parse(content, "md")

      expect(versions["0.7.0"]).to be_present
    end
  end

  def open_changelog_fixture(project)
    File.open(Rails.root.join("spec/fixtures", project)).read
  end
end
