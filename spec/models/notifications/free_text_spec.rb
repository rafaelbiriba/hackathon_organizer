require "rails_helper"

RSpec.describe Notifications::FreeText do
  let(:extra_params) { {title: "title 123", description: "description 123", link: "link 123"} }
  subject { Notifications::FreeText.new(extras: extra_params) }

  describe "metadata" do
    it "should return the correct title" do
      expect(subject.title).to eq(extra_params[:title])
    end

    it "should return the correct text" do
      expect(subject.text).to eq(extra_params[:text])
    end

    it "should return the correct link" do
      expect(subject.link).to eq(extra_params[:link])
    end
  end
end
