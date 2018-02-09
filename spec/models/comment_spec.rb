require "rails_helper"

RSpec.describe Comment do
  describe "validations" do
    it { should validate_presence_of(:body) }
  end

  describe "relationships" do
    it { should belong_to(:project) }
    it { should belong_to(:owner).class_name("User") }
  end
end
