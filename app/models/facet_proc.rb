class FacetProc
  def self.calculate(objs)
    arr = []
    objs[0].class.column_names.each do |n|
      arr << Facet.new(n)
    end
    arr
  end
end
