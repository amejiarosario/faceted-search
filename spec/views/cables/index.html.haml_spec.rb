require 'spec_helper'

describe "cables/index" do
  before(:each) do
    assign(:cables, [
      stub_model(Cable,
        :filename => "Filename",
        :level => 1,
        :part_type => "Part Type",
        :item_number => "Item Number",
        :mfg_part_number => "Mfg Part Number",
        :item_description => "Item Description",
        :type => "Type",
        :conductor => "Conductor",
        :number_pairs => "Number Pairs",
        :insulation => "Insulation",
        :jacket => "Jacket",
        :shielding => "Shielding",
        :wire_gauge => "Wire Gauge",
        :diameter => "Diameter",
        :putup => "Putup",
        :color => "Color",
        :stranding => "Stranding",
        :kevlar_core => "Kevlar Core",
        :pitch => "Pitch"
      ),
      stub_model(Cable,
        :filename => "Filename",
        :level => 1,
        :part_type => "Part Type",
        :item_number => "Item Number",
        :mfg_part_number => "Mfg Part Number",
        :item_description => "Item Description",
        :type => "Type",
        :conductor => "Conductor",
        :number_pairs => "Number Pairs",
        :insulation => "Insulation",
        :jacket => "Jacket",
        :shielding => "Shielding",
        :wire_gauge => "Wire Gauge",
        :diameter => "Diameter",
        :putup => "Putup",
        :color => "Color",
        :stranding => "Stranding",
        :kevlar_core => "Kevlar Core",
        :pitch => "Pitch"
      )
    ])
  end

  it "renders a list of cables" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    # assert_select "tr>td", :text => "Filename".to_s, :count => 2
    # assert_select "tr>td", :text => 1.to_s, :count => 2
     assert_select "tr>td", :text => "Part Type".to_s, :count => 2
     assert_select "tr>td", :text => "Item Number".to_s, :count => 2
    # assert_select "tr>td", :text => "Mfg Part Number".to_s, :count => 2
     assert_select "tr>td", :text => "Item Description".to_s, :count => 2
     assert_select "tr>td", :text => "Type".to_s, :count => 2
    # assert_select "tr>td", :text => "Conductor".to_s, :count => 2
    # assert_select "tr>td", :text => "Number Pairs".to_s, :count => 2
    # assert_select "tr>td", :text => "Insulation".to_s, :count => 2
    # assert_select "tr>td", :text => "Jacket".to_s, :count => 2
    # assert_select "tr>td", :text => "Shielding".to_s, :count => 2
    # assert_select "tr>td", :text => "Wire Gauge".to_s, :count => 2
    # assert_select "tr>td", :text => "Diameter".to_s, :count => 2
    # assert_select "tr>td", :text => "Putup".to_s, :count => 2
    # assert_select "tr>td", :text => "Color".to_s, :count => 2
    # assert_select "tr>td", :text => "Stranding".to_s, :count => 2
    # assert_select "tr>td", :text => "Kevlar Core".to_s, :count => 2
    # assert_select "tr>td", :text => "Pitch".to_s, :count => 2
  end
end
