class FacetProc
  def self.calculate(objs)
    arr = []
    model = objs[0].class
    model.column_names.each do |column|
      f = Facet.new(column)
      f.options = model.select(column.to_sym)
        .uniq.map { |c| c.send(column)}
        .delete_if { |n| n.nil? || n.blank? }
      arr << f
    end
    arr
  end
end
