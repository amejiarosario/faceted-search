class Facet < ActiveRecord::Base
  def self.calculate(model)
    hash = create_hash(model)
    hash
  end
  
  private
    def self.create_hash(model)
      hash = {}
      empty_values = 0
      
      total = model.count
      
      model.column_names.each do |name|
        nil_values = 0
        # get options
        options_name = model.select(name.to_sym)
          .uniq.map { |c| c.send(name) if c.send(name)}
          .delete_if do |n|
            nil_values +=1 
            n.nil? || !(n =~ /\w/) 
        end
                
        options = {}
        options_name.each do |n|
          count = Cable.where(name.to_sym => n).count
          options[n] = count
        end  
        
        puts "29 options=#{options}"
        puts "30 options_name=#{options_name}"
        hash[name] = { 
          "relevance" => relevance(options, total, nil_values),
          "options" => options 
        }
      end
      hash    
    end
    
    def self.relevance(options, total, nil_values)
      if total && total < 1
        return 0.0
      end
      # get median percentage
      puts "#{options}, #{total}, #{nil_values}"
      median_per = median(options.values.map{|n| Float(n)*100/10 })
      puts "median_per=#{median_per}"
      puts "relevance (options.values.inject(:+)) = #{options.values.inject(:+)}"
      options.values.inject(:+) * gauss(median_per/total)
    end
    
    def self.gauss(percentage)
      34/Math::sqrt(2*Math::PI*180)*Math::E**(-0.5*(percentage-50)**2/180)
    end
    
    def self.median(array)
      array.sort[array.count/2-1]
    end
end
