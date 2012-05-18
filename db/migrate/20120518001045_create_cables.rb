class CreateCables < ActiveRecord::Migration
  def change
    create_table :cables do |t|
      t.string :filename
      t.integer :level
      t.string :part_type
      t.string :item_number
      t.string :mfg_part_number
      t.string :item_description
      t.string :type
      t.string :conductor
      t.string :number_pairs
      t.string :insulation
      t.string :jacket
      t.string :shielding
      t.string :wire_gauge
      t.string :diameter
      t.string :putup
      t.string :color
      t.string :stranding
      t.string :kevlar_core
      t.string :pitch

      t.timestamps
    end
  end
end
