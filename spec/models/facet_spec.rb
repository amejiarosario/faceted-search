require 'spec_helper'

describe Facet do
  it "should get column names from model and relevance" do
    actual = Facet.calculate(Cable)
    actual.each do |k,v|
      Cable.column_names.should include k
      #puts "#{k} => #{v}"
      v.keys.should include "relevance"
      v.keys.should include "options"
    end
  end
  
  it "gets relevance for each column based on the data" do
    
    # create 10 cables
    5.times do
      FactoryGirl.create(:cable)
      FactoryGirl.create(:cable2)
    end
    
    
    # perform operation
    actual = Facet.calculate(Cable)
    
    describe "relevance calculations" do
      it "should have the correct number of options" do
        actual["type"]["options"].should eq(["coax", "flat"])
        actual["type"]["options"].count.should be 2
        actual["item_number"]["options"].count.should be 10
      end
      
      it "should omit empty options" do
        actual["number_pairs"]["options"].should eq(["2"])
        actual["number_pairs"]["options"].count.should be 1
        actual["pitch"]["options"].count.should be 2
        actual["kevlar_core"]["options"].count.should be 1
      end
      
      it "should get relevance=1 with all values equal" do
        actual["filename"]["relevance"].should be_close 1, 0.1  
      end
      
      it "should get relevance > 1 for >1 distint values" do
        actual["type"]["relevance"].should be_close 2, 0.1
      end
      
      it "should get relevance=0 with all null values" do
        actual["item_description"]["relevance"].should be_close 0, 0.1
      end
      
      describe "Normal Distribution (Gauss)" do
        it "should have a relevance=0 when all the values are the same" do
          actual["item_number"]["relevance"].should be_close 0, 0.1
        end
              
        it "return >1 for 50% of different values" do
          actual["item_number"]["relevance"].should be_close 2, 0.1
        end
         
      end
      
      it "should order by relevance"
        
    end
  end  
end
