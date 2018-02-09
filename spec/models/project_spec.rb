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
end
