require 'spec_helper'

describe Facet do
  it "should get column names from model"
  it "gets relevance for each column based on the data"
  
  describe "relevance calculations" do
    it "should get relevance=0 with all null values"
    it "should get relevance=1 with all values equal"
    it "should get relevance > 1 for >1 distint values"
    it "should order by relevance"
    describe "Normal Distribution (Gauss)" do
      it "return 0 for 0% different values"
      it "returns 0 for 100% of different values"
      it "return 1 for 50% of different values" 
    end
  end
end
