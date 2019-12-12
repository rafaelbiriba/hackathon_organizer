require "rails_helper"

RSpec.describe Notifications::NewComment do
  subject { create(:notification_new_comment) }

  describe "metadata" do
    it "should return the correct title" do
      expect(subject.title).to eq("New comment")
    end

    it "should return the correct text" do
      expect(subject.text).to eq("New comment from <b>#{subject.user_related.name}</b> at the project <b>#{subject.project.title.truncate(Notification::PROJECT_TITLE_LENGTH)}</b>")
    end

    it "should return the correct link" do
      expect(subject.link).to eq("/projects/#{subject.project.id}#comment-#{subject.comment.id}")
    end
  end

  describe ".notify_all_involved_users" do
    let(:comment1) { create(:comment) }
    let(:comment2) { create(:comment) }
    let(:comment3) { create(:comment) }
    let(:last_comment) { create(:comment, project: project) }

    let!(:project) { create(:project, comments: [comment1, comment2, comment3]) }

    before do
      Notifications::NewComment.destroy_all
      last_comment #create the last comment
    end

    let(:notifications) { Notifications::NewComment.all }
    let(:user_targets) { notifications.collect(&:user_target) }

    it "should not notify the owner of the comment" do
      expect(user_targets).to_not include([last_comment.owner])
    end

    it "should notify all involved users" do
      expect(notifications.count).to eq(4) #Project owner + 3 comments of let
      expect(user_targets).to eq([project.owner, comment1.owner, comment2.owner, comment3.owner])
    end

    it "should set the correct project if at the notification" do
      target_comment_id = notifications.collect(&:comment_id).uniq
      expect(target_comment_id).to eq([last_comment.id])
    end
  end
end
