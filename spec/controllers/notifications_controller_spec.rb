require "rails_helper"

RSpec.describe NotificationsController, :type => :controller do
  let!(:logged_user) { create(:user) }

  before do
    session[:current_user_id] = logged_user.id
  end

  it { should use_before_action(:set_notifications) }
  it { should use_before_action(:clean_old_notifications) }
  # TODO: Because shoulda gem still does not implement except for use_after_action methods
  # Some of the callbacks actions need to be manually validated below.
  #
  #   it { should use_after_action(:mark_all_as_visualized, except: :counter) }

  describe "GET #index" do
    let!(:notification1) { create(:notification_project, user_target: logged_user) }
    let!(:notification2) { create(:notification_project, user_target: logged_user) }

    it { should route(:get, "/notifications").to(action: :index) }

    before do
      get :index
    end

    it "should mark all notifications as visualized" do
      expect(notification1.reload.visualized).to eq(true)
      expect(notification2.reload.visualized).to eq(true)
    end

    it "should assigns all users ordered by name" do
      expect(assigns(:notifications)).to eq([notification2, notification1])
    end
  end

  describe "DELETE #destroy_all" do
    it { should route(:delete, "/notifications/destroy_all").to(action: :destroy_all) }

    before do
      Notification.destroy_all
      create(:notification_project, user_target: logged_user)
      delete :destroy_all
    end

    it { should set_flash[:notice].to("All notifications was successfully removed.") }

    it { should redirect_to(notifications_url) }

    it "should delete all notifications of the user" do
      expect(logged_user.notifications).to be_empty
    end
  end

  describe "GET #counter" do
    it { should route(:get, "/notifications/counter").to(action: :counter) }

    before do
      Notification.destroy_all
      create(:notification_project, user_target: logged_user)
      create(:notification_project, user_target: logged_user, visualized: true)
      create(:notification_project, user_target: logged_user)
      get :counter
    end

    it "should return the couter of all not visualized notifications" do
      expect(JSON.parse(response.body)["notifications_count"]).to eq(2)
    end
  end
end
