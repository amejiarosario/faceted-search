class Cable < ActiveRecord::Base
  attr_accessible :color, :conductor, :diameter, :filename, :insulation, :item_description, :item_number, :jacket, :kevlar_core, :level, :mfg_part_number, :multi, :number_pairs, :part_type, :pitch, :putup, :shielding, :stranding, :type, :wire_gauge
end
