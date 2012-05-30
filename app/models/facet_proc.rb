class FacetProc
  def self.calculate(objs)
    return nil if objs.nil? or objs[0].nil?
    
    arr = []
    model = objs[0].class
    model.column_names.each do |column|
      f = Facet.new(column)
      #options names
      # FIXED don't use model to select options... use the object! (in case is a subset)
      options = objs.map { |c| c.send(column)}.uniq
        .delete_if { |n| n.nil? || n.blank? }
      
      #options + count => hash
      options_hash = {total: objs.count }
      options.each do |n|
        options_hash[n] = model.where(column.to_sym => n).count
      end
    
      f.options = options_hash #.sort {|a,b| a[1] <=> b[1] } #sort by value #TODO sort by value
      arr << f
    end
    #arr.sort {|a,b| b.relevance <=> a.relevance} #works fine btw
    arr.sort {|a,b| b <=> a} # reverse order as well
  end
end
