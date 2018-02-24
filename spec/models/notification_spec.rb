require "rails_helper"

RSpec.describe Notification do
  describe "relationships" do
    # TODO: Enable the .optional (not available at the current version of shoulda-matchers at 3.1.2)
    # New line should be: it { should belong_to(:user_related).class_name("User").optional }
    it { should belong_to(:user_related).class_name("User") }
    it { should belong_to(:user_target).class_name("User") }
    # TODO: Enable the .optional (not available at the current version of shoulda-matchers at 3.1.2)
    # New line should be: it { should belong_to(:project).optional }
    it { should belong_to(:project) }
    # TODO: Enable the .optional (not available at the current version of shoulda-matchers at 3.1.2)
    # New line should be: it { should belong_to(:comment).optional }
    it { should belong_to(:comment) }
  end

  describe "extras field" do
    let!(:generic_notification) { create(:notification_project, extras: { param: 123 })}
    it "should store extras as hash" do
      expect(Notification.last.extras).to include(:param)
    end
  end

  describe "scopes" do
    describe "#not_visualized" do
      let!(:generic_notification_no_visualized) { create(:notification_project, visualized: false) }
      let!(:generic_notification_visualized) { create(:notification_project, visualized: true) }
      it "should return only the notifications not visualized" do
        expect(Notification.not_visualized).to eq([generic_notification_no_visualized])
      end
    end

    describe "#old_visualized_notifications" do
      let!(:generic_notification_old_visualized) { create(:notification_project, visualized: true, created_at: 5.days.ago) }
      let!(:generic_notification_new_visualized) { create(:notification_project, visualized: true) }
      let!(:generic_notification_new_no_visualized) { create(:notification_project, visualized: false) }
      it "should return only the notifications visualized and old" do
        expect(Notification.old_visualized_notifications).to eq([generic_notification_old_visualized])
      end
    end
  end
end
