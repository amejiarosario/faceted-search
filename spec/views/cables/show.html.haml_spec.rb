require 'spec_helper'

describe "cables/show" do
  before(:each) do
    @cable = assign(:cable, stub_model(Cable,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Filename/)
    rendered.should match(/1/)
    rendered.should match(/Part Type/)
    rendered.should match(/Item Number/)
    rendered.should match(/Mfg Part Number/)
    rendered.should match(/Item Description/)
    rendered.should match(/Type/)
    rendered.should match(/Conductor/)
    rendered.should match(/Number Pairs/)
    rendered.should match(/Insulation/)
    rendered.should match(/Jacket/)
    rendered.should match(/Shielding/)
    rendered.should match(/Wire Gauge/)
    rendered.should match(/Diameter/)
    rendered.should match(/Putup/)
    rendered.should match(/Color/)
    rendered.should match(/Stranding/)
    rendered.should match(/Kevlar Core/)
    rendered.should match(/Pitch/)
  end
end
