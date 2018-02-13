require "rails_helper"

RSpec.describe Project do
  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
  end

  describe "callbacks" do
    it { is_expected.to callback(:destroy_notifications).before(:destroy) }
  end

  describe "relationships" do
    it { should have_and_belong_to_many(:subscribers).class_name("User") }
    it { should belong_to(:owner).class_name("User") }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:thumbs_up).dependent(:destroy) }
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
