class Facet
  attr_accessor :name, :options, :relevance
  
  def initialize(name)
    @options = []
    @name = name
    @relevance = 0 
  end
  
end
