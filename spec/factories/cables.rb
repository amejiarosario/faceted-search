# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  
  factory :cable do
    filename "10012-0703_E_MfgBOMReport.xls"
    level 0
    part_type "Cable and Wire" 
    sequence(:item_number) {|n| "10012-0703-#{n.to_s}"}
    sequence(:mfg_part_number) {|n| "E        C51116-#{n.to_s}"}
    item_description "CABLE ASSY, ANT PA CONTROL"
    type "coax"
    conductor "6"
    number_pairs "2"
    insulation "Irradiated PVC"
    jacket "PVC"
    shielding "E/D"
    wire_gauge "6-22awg"
    diameter "0.276"
    putup "1000"
    color "Orange"
    stranding "19/30"
    kevlar_core "No"
    pitch "0.050"
  end
  
end
