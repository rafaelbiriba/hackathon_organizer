require "rails_helper"

RSpec.describe Notifications::RemovedThumbsUp do
  subject { create(:notification_removed_thumbs_up) }

  describe "metadata" do
    it "should return the correct title" do
      expect(subject.title).to eq("Thumbs up removed")
    end

    it "should return the correct text" do
      expect(subject.text).to eq("The user <b>#{subject.user_related.name}</b> just removed the <b>thumbs up</b> from the project <b>#{subject.project.title.truncate(Notification::PROJECT_TITLE_LENGTH)}</b>")
    end

    it "should return the correct link" do
      expect(subject.link).to eq("/editions/#{subject.project.edition.id}/projects/#{subject.project.id}")
    end
  end
end
