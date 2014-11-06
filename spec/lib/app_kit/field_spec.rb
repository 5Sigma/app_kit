describe AppKit::Field do
  %w(editable formatter show_in_table show_in_details editable).each do |attr|
    describe "##{attr}" do
      it "should set value" do
        field = AppKit::Field.new(Customer, :name)
        field.send(attr.to_sym, :test)
        expect(field.send(attr.to_sym)).to eq(:test)
      end
    end
  end
end
