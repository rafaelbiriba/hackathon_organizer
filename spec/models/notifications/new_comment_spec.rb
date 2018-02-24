require "rails_helper"

RSpec.describe Notifications::NewComment do
  subject { build(:notification_new_comment) }

  describe "metadata" do
    it "should return the correct title" do
      expect(subject.title).to eq("New comment")
    end

    it "should return the correct text" do
      expect(subject.text).to eq("New comment from <b>#{subject.user_related.name}</b> at the project <b>#{subject.project.title}</b>")
    end

    it "should return the correct link" do
      expect(subject.link).to eq("/projects/#{subject.project.id}#comment-#{subject.comment.id}")
    end
  end
end
