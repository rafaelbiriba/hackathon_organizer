require "rails_helper"

RSpec.describe Notifications::NewThumbsUp do
  subject { create(:notification_new_thumbs_up) }

  describe "metadata" do
    it "should return the correct title" do
      expect(subject.title).to eq("New thumbs up")
    end

    it "should return the correct text" do
      expect(subject.text).to eq("The user <b>#{subject.user_related.name}</b> just <b>thumbs up</b> the project <b>#{subject.project.title.truncate(Notification::PROJECT_TITLE_LENGTH)}</b>")
    end

    it "should return the correct link" do
      expect(subject.link).to eq("/projects/#{subject.project.id}#thumbs-up")
    end
  end
end
