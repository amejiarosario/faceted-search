class FacetProc
  def self.calculate(objs)
    arr = []
    model = objs[0].class
    model.column_names.each do |column|
      f = Facet.new(column)
      #options names
      # FIXME don't use model to select options... use the object! (in case is a subset)
      options = model.select(column.to_sym)
        .uniq.map { |c| c.send(column)}
        .delete_if { |n| n.nil? || n.blank? }
      
      #options + count => hash
      options_hash = {}
      options.each do |n|
        options_hash[n] = model.where(column.to_sym => n).count
      end
      
      f.options = options_hash
      arr << f
    end
    arr
  end
end
