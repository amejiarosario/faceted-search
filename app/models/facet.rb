class Facet < ActiveRecord::Base
  def self.calculate(model)
    hash = create_hash(model)
    hash
  end
  
  private
    def self.create_hash(model)
      hash = {}
      model.column_names.each do |name|
        hash[name] = { "relevance" => 0.0, "elements" => [] }
        # do calc
      end
      hash    
    end
end
