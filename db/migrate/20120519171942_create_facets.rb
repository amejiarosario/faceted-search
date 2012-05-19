#FIXME delete this file
class CreateFacets < ActiveRecord::Migration
  def change
    create_table :facets do |t|

      t.timestamps
    end
  end
end
