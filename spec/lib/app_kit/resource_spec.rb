require "spec_helper"

class TestModel

end


describe AppKit::Resource do
  let(:resource) { AppKit::Resource.new(TestModel) }
  describe "#field" do
    it "should add to fields list" do
      expect {
      resource.field(:test)
      }.to change(resource.fields, :count).by(1)
    end
  end
end
