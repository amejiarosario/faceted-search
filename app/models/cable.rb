class Cable < ActiveRecord::Base
  resourcify # put a role on
  
  self.inheritance_column = 'something_you_will_not_use'
  attr_accessible :color, :conductor, :diameter, :filename, :insulation, :item_description, :item_number, :jacket, :kevlar_core, :level, :mfg_part_number, :number_pairs, :part_type, :pitch, :putup, :shielding, :stranding, :type, :wire_gauge
  validates :item_number, :uniqueness => true
  
  def self.search(search)
    if search
      where('item_description LIKE ? OR item_number LIKE ? OR type LIKE ? OR number_pairs LIKE ? OR conductor LIKE ? OR wire_gauge LIKE ?', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end
  
end
