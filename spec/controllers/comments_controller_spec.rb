require "rails_helper"

RSpec.describe CommentsController, :type => :controller do
  let!(:logged_user) { create(:user) }
  let(:project) { create(:project) }

  before do
    session[:current_user_id] = logged_user.id
  end

  it { should use_before_action(:set_project) }

  describe "POST #create" do
    it { should route(:post, "/projects/#{project.id}/comments").to(action: :create, project_id: project.id) }

    let(:comment_params) { { body: "My comment!" } }

    context "when the comment is created properly" do
      before do
        post :create, params: { project_id: project.id, comment: comment_params }
      end

      it "should create the comment" do
        last_comment = Comment.last
        expect(last_comment.body).to eq(comment_params[:body])
        expect(last_comment.project).to eq(project)
        expect(last_comment.owner).to eq(logged_user)
      end

      it { should set_flash[:notice].to("Your comment was successfully created.") }

      it do
        last_comment = Comment.last
        should redirect_to(project_path(project, anchor: "comment-#{last_comment.id}"))
      end
    end

    context "when something is wrong" do
      before do
        post :create, params: { project_id: project.id, comment: { body: "" } }
      end

      it { should set_flash[:error].to("Something is wrong!") }
      it {should render_template("projects/show") }
    end
  end
end
