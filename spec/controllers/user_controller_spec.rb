require "rails_helper"

RSpec.describe UsersController, :type => :controller do

  let!(:user_c) { create(:user, name: "c") }
  let!(:user_admin_z) { create(:user, name: "z", is_admin: true) }
  let!(:user_a) { create(:user, name: "a") }

  let(:logged_user) { user_admin_z }

  before do
    session[:current_user_id] = logged_user.id
  end

  it { should use_before_action(:validate_admin_user) }
  # TODO: Because shoulda gem still does not implement except for use_before_action methods
  # Some of the callbacks actions need to be manually validated below.
  #
  #   it { should use_before_action(:find_user, except: :index) }
  #   it { should use_before_action(:check_for_superuser, only: :revoke_user_admin) }

  shared_examples "validating logged user" do
    context "when the logged user is not an admin" do
      let(:logged_user) { user_a }

      it { should set_flash[:error].to("You are not an admin.") }
      it { should redirect_to(root_url) }
    end

    context "when the logged user is an admin" do
      let(:logged_user) { user_admin_z }

      it { should_not set_flash[:error] }
    end
  end

  describe "GET #index" do
    it { should route(:get, "/users").to(action: :index) }

    before do
      get :index
    end

    include_examples "validating logged user"

    it { should render_template("users/index") }

    it "should assigns all users ordered by name" do
      expect(assigns(:users)).to eq([user_a, user_c, user_admin_z])
    end
  end

  describe "GET #give_user_admin" do
    it { should route(:get, "/users/#{user.id}/give_user_admin").to(action: :give_user_admin, id: user.id) }

    before do
      get :give_user_admin, params: { id: user.id }
    end

    let!(:user) { create(:user, is_admin: false) }

    include_examples "validating logged user"

    it "should give the admin flag to the user" do
      expect(user.reload.is_admin).to eq(true)
    end

    it { should redirect_to(users_url) }
    it { should set_flash[:notice].to("#{user.name} is now an admin.") }
  end

  describe "DELETE #revoke_user_admin" do
    it { should route(:delete, "/users/#{user.id}/revoke_user_admin").to(action: :revoke_user_admin, id: user.id) }

    before do
      delete :revoke_user_admin, params: { id: user.id }
    end

    let!(:user) { create(:user, is_admin: true) }

    include_examples "validating logged user"

    it "should remove the admin flag to the user" do
      expect(user.reload.is_admin).to eq(false)
    end

    it { should redirect_to(users_url) }
    it { should set_flash[:notice].to("#{user.name} is no longer an admin.") }

    context "when the user is a superuser" do
      let!(:user) { create(:user, is_admin: true, is_superuser: true) }

      it { should set_flash[:error].to("You can not remove the admin power of this user.") }
      it { should redirect_to(root_url) }
    end
  end
end
