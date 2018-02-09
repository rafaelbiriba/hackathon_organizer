require "rails_helper"

RSpec.describe ThumbsUp do
  describe "relationships" do
    it { should belong_to(:project) }
    it { should belong_to(:creator).class_name("User") }
  end
end
