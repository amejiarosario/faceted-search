class Facet
  attr_accessor :name, :options, :relevance
  
  def initialize(name)
    @options = {}
    @name = name
  end

  def relevance
    @relevance ||= calculate
  end

  private
    def calculate
      0.0 if @options.count < 1
      percentage = median(@options.values.map { |n| Float(n)*100/@options.count})
      @options.values.inject(:+) * gauss(percentage)
    end

    def median(array)
      array.sort[array.count/2-1]
    end

    def gauss(percentage)
      percentage ||= 0
      34/Math::sqrt(2*Math::PI*180)*Math::E**(-0.5*(percentage-50)**2/180)
    end

end
