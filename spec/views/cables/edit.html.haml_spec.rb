require 'spec_helper'

describe "cables/edit" do
  before(:each) do
    @cable = assign(:cable, stub_model(Cable,
      :filename => "MyString",
      :level => 1,
      :part_type => "MyString",
      :item_number => "MyString",
      :mfg_part_number => "MyString",
      :item_description => "MyString",
      :type => "",
      :conductor => "MyString",
      :number_pairs => "MyString",
      :insulation => "MyString",
      :jacket => "MyString",
      :shielding => "MyString",
      :wire_gauge => "MyString",
      :diameter => "MyString",
      :putup => "MyString",
      :color => "MyString",
      :multi => "MyString",
      :stranding => "MyString",
      :kevlar_core => "MyString",
      :pitch => "MyString"
    ))
  end

  it "renders the edit cable form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cables_path(@cable), :method => "post" do
      assert_select "input#cable_filename", :name => "cable[filename]"
      assert_select "input#cable_level", :name => "cable[level]"
      assert_select "input#cable_part_type", :name => "cable[part_type]"
      assert_select "input#cable_item_number", :name => "cable[item_number]"
      assert_select "input#cable_mfg_part_number", :name => "cable[mfg_part_number]"
      assert_select "input#cable_item_description", :name => "cable[item_description]"
      assert_select "input#cable_type", :name => "cable[type]"
      assert_select "input#cable_conductor", :name => "cable[conductor]"
      assert_select "input#cable_number_pairs", :name => "cable[number_pairs]"
      assert_select "input#cable_insulation", :name => "cable[insulation]"
      assert_select "input#cable_jacket", :name => "cable[jacket]"
      assert_select "input#cable_shielding", :name => "cable[shielding]"
      assert_select "input#cable_wire_gauge", :name => "cable[wire_gauge]"
      assert_select "input#cable_diameter", :name => "cable[diameter]"
      assert_select "input#cable_putup", :name => "cable[putup]"
      assert_select "input#cable_color", :name => "cable[color]"
      assert_select "input#cable_multi", :name => "cable[multi]"
      assert_select "input#cable_stranding", :name => "cable[stranding]"
      assert_select "input#cable_kevlar_core", :name => "cable[kevlar_core]"
      assert_select "input#cable_pitch", :name => "cable[pitch]"
    end
  end
end
