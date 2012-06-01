class FacetProc
  def self.calculate(objs)
    return nil if objs.nil? or objs[0].nil?
    
    arr = []
    model = objs.first.class
    model.column_names.each do |column|
      f = Facet.new(column)
      
      #options names
      # DONE don't use model to select options... use the object! (in case is a subset)
      
      options = objs.map { |c| c.send(column)}
        .delete_if { |n| n.nil? || n.blank? } # TODO count blank elements as any other category...

      options_hash = Hash.new(0)
      options_hash[:total] = objs.count
      
      options.each do |n|
        if n.nil? || n.blank?
          options_hash[:blank] += 1
        else
          options_hash[n] += 1
        end
      end
    
      f.options = options_hash #.sort {|a,b| a[1] <=> b[1] } #sort by value #TODO sort by value
      arr << f
    end
    #arr.sort {|a,b| b.relevance <=> a.relevance} #works fine btw
    arr.sort {|a,b| b <=> a} # reverse order as well
  end
end
