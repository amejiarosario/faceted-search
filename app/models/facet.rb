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
        
        hash[name] = { 
          "relevance" => relevance(options.count, total),
          "options" => options 
        }
      end
      #puts hash
      hash    
    end
    
    def self.relevance(no_options, total)
      no_options
    end
    
    def self.gauss(percentage)
      34/Math::sqrt(2*Math::PI*180)*Math::E**(-0.5*(percentage-50)**2/180)
    end
end
