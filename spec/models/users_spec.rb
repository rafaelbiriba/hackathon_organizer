require "rails_helper"

RSpec.describe User do
  describe "required attributes validations" do
    describe "for email" do
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
  end
end
