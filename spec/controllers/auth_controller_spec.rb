require "rails_helper"

RSpec.describe AuthController, :type => :controller do
  it { should_not use_before_action(:validate_user_logged) }
  it { should_not use_before_action(:define_notifications_counter) }

  describe "GET #login" do
    before do
      get :login
    end

    it { should route(:get, "/auth/login").to(action: :login) }
    it { should render_template("auth/login") }
  end

  describe "GET #failure" do
    it { should route(:get, "/auth/failure").to(action: :failure) }

    before do
      get :failure, params: { message: "error!" }
    end

    it "should render the error message" do
      expect(response.body).to eq("error!")
    end
  end

  describe "GET|POST #callback" do
    let(:user) { build(:user) }
    let(:oauth_data) do
      OpenStruct.new({
        email: user.email,
        name: user.name,
        image: user.profile_image_url
      })
    end

    before do
      User.destroy_all
      @request.env["omniauth.auth"] = double("Data", info: oauth_data)
    end

    shared_examples "callback method" do |method|
      before do
        send(method, :callback, params: { provider: "google" })
      end

      it { should route(method, "/auth/google/callback").to(action: :callback, provider: "google") }

      describe "when happy path" do
        it { should redirect_to(projects_url) }

        context "if the user doesn't exists" do
          let(:user) { build(:user) }

          it "should create the user if it does not exists" do
            expect(User.count).to eq(1)
            last_user = User.last
            expect(last_user.email).to eq(oauth_data.email)
            expect(last_user.name).to eq(oauth_data.name)
            expect(last_user.profile_image_url).to eq(oauth_data.image)
          end

          it "should create a new session with the user" do
            expect(session[:current_user_id]).to eq(User.last.id)
          end
        end

        context "if the user already exists" do
          let(:user) { create(:user) }

          let(:oauth_data) do
            OpenStruct.new({
              email: user.email,
              name: "new name",
              image: "http://new_image.jpg"
            })
          end

          it "should update the user information" do
            expect(User.count).to eq(1)
            last_user = User.last
            expect(last_user.email).to eq(oauth_data.email)
            expect(last_user.name).to eq(oauth_data.name)
            expect(last_user.profile_image_url).to eq(oauth_data.image)
          end

          it "should create a new session with the user" do
            expect(session[:current_user_id]).to eq(user.id)
          end
        end
      end
    end

    context "GET" do
      include_examples "callback method", :get
    end

    context "POST" do
      include_examples "callback method", :post
    end
  end

  describe "GET #logout" do
    before do
      session[:current_user_id] = 123
      get :logout
    end

    it { should route(:get, "/auth/logout").to(action: :logout) }
    it { should set_flash[:notice].to("You have successfully logged out.") }
    it { should redirect_to(auth_login_url) }
    it "should remove the user from the session" do
      expect(session[:current_user_id]).to be_nil
    end
  end

end
