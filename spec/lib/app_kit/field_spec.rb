describe AppKit::Field do
  %w(editable formatter show_in_table show_in_details display_name
  editable show_in_filters enum).each do |attr|
    describe "##{attr}" do
      it "should set value" do
        field = AppKit::Field.new(Customer, :name)
        field.send(attr.to_sym, :test)
        expect(field.send(attr.to_sym)).to eq(:test)
      end
    end
  end
  describe "dynamic fields" do
    let(:field) {
      AppKit::Field.new Customer, :last_first  do |record|
        "#{record.last_name}, #{record.first_name}"
      end
    }
    it "should assign display_proc" do
      expect(field.display_proc).to_not be_nil
    end
    it "should display using proc" do
      customer = FactoryGirl.create(:customer,
                                    first_name: 'John',
                                    last_name: 'Doe')
      val = "Doe, John"
      expect(field.value_for_record(customer)).to eq(val)
    end
    it "should disable filtering" do
      expect(field.show_in_filters).to be(false)
    end
  end
  describe "enum field" do
    let(:enum) {
      { open: 'Open', closed: 'Closed' }
    }
    let(:field) {
      AppKit::Field.new(Customer, :name, enum: enum)
    }
    it "should set editor to enum if enum values are present" do
      expect(field.editor).to eq(:enum)
    end
    it "should set enum in editor_options" do
      expect(field.editor_options[:enum]).to eq (enum)
    end
  end
  describe "value_for_record" do
    let(:customer) { FactoryGirl.create(:customer, first_name: 'open') }
    it "should return field value" do
      field = AppKit::Field.new(Customer,:first_name)
      expect(field.value_for_record(customer)).to eq(customer.first_name)
    end
    it "should return enum value" do
      field = AppKit::Field.new(Customer,:first_name,
                                enum: {open: 'Open', closed: 'Closed'})
      expect(field.value_for_record(customer)).to eq('Open')
    end
  end
end
