require "rails_helper"

RSpec.describe User do
  after { Settings.reload! }

  describe "profile image validation" do
    let(:user) { create(:user) }

    context "when the profile image returns 404" do
      let(:profile_url) { "http://not_exist_url.url" }

      it "should set nil to the profile url" do
        stub_request(:any, profile_url).to_return(status: 404)
        user.profile_image_url = profile_url
        user.save!
        user.reload
        expect(user.profile_image_url).to be_nil
      end
    end

    context "when the profile image exists" do
      let(:profile_url) { "http://exist_url.url" }

      it "should set nil to the profile url" do
        stub_request(:any, profile_url).to_return(status: 200)
        user.profile_image_url = profile_url
        user.save!
        user.reload
        expect(user.profile_image_url).to eq(profile_url)
      end
    end
  end

  describe "email validations" do
    context "when the domain whitelist is empty" do
      before { Settings.allowed_domain = [] }

      it { should_not allow_value("blah").for(:email) }
      it { should allow_value("a@b.com").for(:email) }
      it { should validate_uniqueness_of(:email) }
    end

    context "when there is a domain restriction" do
      let(:allowed_domain) { "allowed.com" }
      before { Settings.allowed_domain = [allowed_domain] }

      it { should allow_value("test@#{allowed_domain}").for(:email) }
      it { should_not allow_value("a@b.com").for(:email).with_message("domain not allowed") }
    end
  end

  describe "relationships" do
    it { should have_many(:projects).with_foreign_key("owner_id") }
    it { should have_and_belong_to_many(:subscriptions).class_name("Project") }
    it { should have_many(:comments).with_foreign_key("owner_id") }
    it { should have_many(:notifications).with_foreign_key("user_target_id") }
    it { should have_many(:thumbs_up).with_foreign_key("creator_id") }
  end
end
