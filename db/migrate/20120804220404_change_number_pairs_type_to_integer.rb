class ChangeNumberPairsTypeToInteger < ActiveRecord::Migration
  def up
    remove_column :cables, :number_pairs
    add_column :cables, :number_pairs, :integer #, default: 0
  end

  def down
    remove_column :cables, :number_pairs
    add_column :cables, :number_pairs, :string
  end
end
