# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  
  factory :cable do
    filename "10012-0703_E_MfgBOMReport.xls"
    level 0
    part_type "Cable and Wire" 
    sequence(:item_number) {|n| "10012-0703-#{n.to_s}"}
    sequence(:mfg_part_number) {|n| "E        C51116-#{n.to_s}"}
    item_description ""
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
    
    factory :cable2 do
      part_type "Assembly"
      type "flat"
      number_pairs ""
      pitch "  0.040"
      kevlar_core "  "
      #item_number "10511-1357-01"
      #mfg_part_number "B        C31754"
      #empty spaces testing
    end
    
  end
end
