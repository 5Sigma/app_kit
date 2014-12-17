require 'spec_helper'

RSpec.describe AppKit::Dsl::ApplicationDsl do
  let(:dummy) { AppKit::Application.new }
  describe "#title" do
    it "should set title in config" do
      dummy.title 'test title'
      expect(dummy.config.application_title).to eq('test title')
    end
  end
  describe "#disable_authentication" do
    it "should disable authentication in config" do
      dummy.disable_authentication
      expect(dummy.config.authentication_enabled).to eq(false)
    end
  end
end
