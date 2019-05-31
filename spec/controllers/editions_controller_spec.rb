require "rails_helper"

RSpec.describe EditionsController, :type => :controller do
  let!(:logged_user) { create(:user) }

  before do
    session[:current_user_id] = logged_user.id
  end

  describe "GET #index" do
    let!(:edition1) { create(:edition) }
    let!(:edition2) { create(:edition, base_date: Time.now + 10.days) }
    let!(:edition3) { create(:edition, base_date: Time.now - 10.days) }

    it { should route(:get, "/editions").to(action: :index) }

    before do
      get :index
    end

    it { should render_template("editions/index") }

    it "should assigns all editions ordered by registration_start_date" do
      expect(assigns(:editions)).to eq([edition2, edition1, edition3])
    end
  end

  describe "GET #show" do
    let!(:edition) { create(:edition) }

    before do
      get :show, params: { id: edition.id }
    end

    it { should route(:get, "/editions/#{edition.id}").to(action: :show, id: edition.id) }

    it { should redirect_to(edition_projects_url(edition_id: edition.id)) }
  end

  describe "GET #active_now" do
    context "if there is no edition active now" do
      let!(:edition1) { create(:edition, base_date: Time.now + 10.days) }
      let!(:edition2) { create(:edition, base_date: Time.now + 20.days) }

      before do
        get :active_now
      end

      it { should set_flash[:error].to("There is no edition active right now! Check the list below!") }

      it { should redirect_to(editions_url) }
    end

    context "if there is one edition active now" do
      let!(:edition1) { create(:edition) }
      let!(:edition2) { create(:edition, base_date: Time.now + 10.days) }

      before do
        get :active_now
      end

      it { should redirect_to(edition_projects_url(edition1)) }
    end
  end
end
