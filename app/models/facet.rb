class Facet < ActiveRecord::Base
  def self.calculate(model)
    hash = create_hash(model)
    hash
  end
  
  private
    def self.create_hash(model)
      hash = {}
      total = model.count
      model.column_names.each do |name|
        # get options
        options = model.select(name.to_sym)
          .uniq.map { |c| c.send(name) if c.send(name)}
          .delete_if { |n| n.nil? || !(n =~ /\w/) }
        
        hash[name] = { "relevance" => options.count, "options" => options }
      end
      #puts hash
      hash    
    end
end
