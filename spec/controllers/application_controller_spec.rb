require "rails_helper"

RSpec.describe ApplicationController, :type => :controller do
  controller do
    def index; end
  end

  let!(:user) { create(:user) }

  it { should use_before_action(:validate_user_logged) }
  it { should use_before_action(:define_notifications_counter) }
  it { should_not use_before_action(:set_current_user) }

  describe "set current user (development only feature)" do
    it "should not set the current user outside development" do
      get :index, params: { user: user.id }
      expect(session[:current_user_id]).to eq(nil)
    end
  end

  describe "validate user logged" do
    before do
      session[:current_user_id] = nil
      get :index
    end

    it { should set_flash[:error].to("You are not logged.") }
    it { should redirect_to(auth_login_url) }
  end
end
