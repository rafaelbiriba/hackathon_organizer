require "rails_helper"

RSpec.describe Project do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
  end

  describe "callbacks" do
    context "before destroy" do
      let(:project) { create(:project) }
      let!(:notification) { create(:notification_project, project: project) }

        it { is_expected.to callback(:destroy_notifications).before(:destroy) }

        it "should remove all notifications related to the project" do
          project.destroy
          expect(Notification.count).to eq 0
        end
    end
  end

  describe "relationships" do
    it { should have_and_belong_to_many(:subscribers).class_name("User") }
    it { should belong_to(:owner).class_name("User") }
    it { should have_many(:comments).dependent(:destroy).order( created_at: :asc ) }
    it { should have_many(:thumbs_up).dependent(:destroy) }

    describe "comments order" do
      let!(:project) { create(:project) }
      let!(:comment1) { create(:comment, created_at: Time.now-2.days, updated_at: Time.now-2.days, project: project) }
      let!(:comment2) { create(:comment, created_at: Time.now-4.days, updated_at: Time.now-4.days, project: project) }
      let!(:comment3) { create(:comment, project: project) }

      before do
        project.reload
      end

      it "should return the comments ordering by created_at" do
        expect(project.comments.to_a).to eq([comment2, comment1, comment3])
      end
    end
  end

  describe "#all_involved_users" do
    let(:project) { build(:project, subscribers: [subscriber1, subscriber2]) }
    let(:subscriber1) { build(:user) }
    let(:subscriber2) { build(:user) }

    context "filtering by owner + subscribers" do
      subject { project.all_involved_users }
      it { should eq [project.owner, subscriber1, subscriber2] }

      context "with except flag" do
        subject { project.all_involved_users(except_user: subscriber1) }
        it { should eq [project.owner, subscriber2] }
      end
    end

    context "filtering by owner + subscribers + commenters" do
      let(:comment) { build(:comment, owner: comenter1) }
      let(:comenter1) { build(:user) }
      let(:project) { build(:project, subscribers: [subscriber1, subscriber2], comments: [comment]) }

      subject { project.all_involved_users(include_commenters: true) }
      it { should eq [project.owner, subscriber1, subscriber2, comenter1] }

      context "with except flag" do
        subject { project.all_involved_users(except_user: subscriber1, include_commenters: true) }
        it { should eq [project.owner, subscriber2, comenter1] }
      end
    end
  end
end
