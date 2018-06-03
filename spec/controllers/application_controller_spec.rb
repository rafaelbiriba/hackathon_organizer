require "rails_helper"

RSpec.describe ApplicationController, :type => :controller do
  controller do
    def index
      render html: "ok"
    end
  end

  let!(:user) { create(:user) }

  it { should use_before_action(:validate_user_logged) }
  it { should use_before_action(:define_notifications_counter) }
  it { should_not use_before_action(:set_current_user) }

  describe "#set_current_user" do
    it "should not set the current user outside development" do
      get :index, params: { user: user.id }
      expect(session[:current_user_id]).to eq(nil)
    end
  end

  describe "#current_user" do
    context "when there is a valid user logged" do
      before do
        session[:current_user_id] = user.id
        get :index
      end

      it "should define the current user" do
        expect(assigns(:current_user)).to eq(user)
      end
    end

    context "when there is no valid user logged" do
      before do
        session[:current_user_id] = 99999
        get :index
      end

      it "should return nil for the current user method" do
        expect(assigns(:current_user)).to eq(nil)
      end
    end
  end

  describe "#validate_user_logged" do
    before do
      session[:current_user_id] = nil
      get :index
    end

    it { should set_flash[:error].to("You are not logged.") }
    it { should redirect_to(auth_login_url) }
  end

  describe "#define_notifications_counter" do
    before do
      session[:current_user_id] = user.id
    end

    context "when there are notifications not visualized" do
      before do
        create(:notification_text, user_target: user)
        create(:notification_text, user_target: user)
        get :index
      end

      it "should return two not visualized notifications" do
        expect(assigns(:new_notifications_count)).to eq(2)
      end
    end

    context "when there are notifications but is all visualized" do
      before do
        create(:notification_text, user_target: user, visualized: true)
        create(:notification_text, user_target: user, visualized: true)
        get :index
      end

      it "should return two not visualized notifications" do
        expect(assigns(:new_notifications_count)).to eq(0)
      end
    end
  end
end
