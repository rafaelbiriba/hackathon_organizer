require "rails_helper"

RSpec.describe Comment do
  describe "validations" do
    it { should validate_presence_of(:body) }
  end

  describe "relationships" do
    it { should belong_to(:project) }
    it { should belong_to(:owner).class_name("User") }
  end

  describe "callbacks" do
    it { is_expected.to callback(:send_notifications).after(:create) }

    describe "#send_notifications" do
      let(:comment) { build(:comment) }

      it "should notify all involved users" do
        expect(Notifications::NewComment).to receive(:notify_all_involved_users).with(comment)
        comment.save!
      end
    end
  end
end
