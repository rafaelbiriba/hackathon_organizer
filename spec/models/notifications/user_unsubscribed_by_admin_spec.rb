require "rails_helper"

RSpec.describe Notifications::UserUnsubscribedByAdmin do
  subject { create(:notification_user_unsubscribed_by_admin) }

  describe "metadata" do
    it "should return the correct title" do
      expect(subject.title).to eq("User unsubscribed by admin")
    end

    it "should return the correct text" do
      expect(subject.text).to eq("The <b>ADMIN user</b> just <b>unsubscribed</b> <b>#{subject.user_related.name}</b> from the project <b>#{subject.project.title.truncate(Notification::PROJECT_TITLE_LENGTH)}</b>")
    end

    it "should return the correct link" do
      expect(subject.link).to eq("/projects/#{subject.project.id}#subscribers-list")
    end
  end
end
