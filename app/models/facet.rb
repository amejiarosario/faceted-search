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
        #puts "name #{name}"
        # get options
        options = model.select(name.to_sym)
          .uniq.map { |c| c.send(name)}
          .delete_if { |n| n.nil? || n.blank? }
          
        #puts "options>#{options}"
        
        options_hash = {}
        options.each do |n|
          options_hash[n] = Cable.where(name.to_sym => n).count
        end
        
        #puts "\n**options_hash <<#{options_hash}>> for <<#{name}>>"
        #binding.pry
        
        hash[name] = { 
          "relevance" => relevance(options_hash, total),
          "options" => options_hash 
        }
      end
      
      #puts hash
      hash    
    end
    
    def self.relevance(options_hash, total)
      #puts "options_hash #{options_hash}; total #{total}"
      #binding.pry
      if total && total < 1 || options_hash.blank?
        return 0.0
      end
      per = median( options_hash.values.map { |n| Float(n)*100/total } )
      options_hash.values.inject(:+) * gauss(per)
    end
    
    def self.gauss(percentage)
      #puts "percentage=#{percentage}"
      percentage ||= 0
      34/Math::sqrt(2*Math::PI*180)*Math::E**(-0.5*(percentage-50)**2/180)
    end
    
    def self.median(array)
      #puts "array #{array}"
      array.sort[array.count/2-1]
    end
end
