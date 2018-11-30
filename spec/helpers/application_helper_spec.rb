require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "markdown" do
    let(:markdown) { "##Headline\nsome text" }
    it "renders markdown to HTML" do
      expect(helper.markdown(markdown)).to eq("<h2>Headline</h2>\n\n<p>some text</p>\n")
    end
  end
end
