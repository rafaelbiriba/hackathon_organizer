require "rails_helper"

RSpec.describe Notifications::UserSubscribed do
  subject { create(:notification_user_subscribed) }

  describe "metadata" do
    it "should return the correct title" do
      expect(subject.title).to eq("User subscribed")
    end

    it "should return the correct text" do
      expect(subject.text).to eq("The user <b>#{subject.user_related.name}</b> just <b>subscribed</b> to the project <b>#{subject.project.title.truncate(Notification::PROJECT_TITLE_LENGTH)}</b>")
    end

    it "should return the correct link" do
      expect(subject.link).to eq("/editions/#{subject.project.edition.id}/projects/#{subject.project.id}#subscribers-list")
    end
  end
end
