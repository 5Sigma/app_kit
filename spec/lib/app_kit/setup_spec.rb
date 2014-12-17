require 'spec_helper'

RSpec.describe AppKit::SetupDsl do
  describe "#title" do
    it "should set title in config" do
      AppKit::SetupDsl.title 'test title'
      expect(AppKit::application.config.application_title).to eq('test title')
    end
  end
  describe "#disable_authentication" do
    after(:each) { AppKit::application.config.authentication_enabled = true }
    it "should disable authentication in config" do
      AppKit::SetupDsl.disable_authentication
      expect(AppKit::application.config.authentication_enabled).to eq(false)
    end
  end
end
