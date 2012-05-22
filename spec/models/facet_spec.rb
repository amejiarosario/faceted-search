describe Facet do
  before :each do
    # create 10 cables
    4.times do
      FactoryGirl.create(:cable)
      FactoryGirl.create(:cable2)
    end
    FactoryGirl.create(:cable, type: "multi") 
    FactoryGirl.create(:cable2, type: "multi")
  end
  
  it "should include column names from model and relevance" do
    actual = Facet.calculate(Cable) # FIXME should pass Cable.all, so it can be get facets from nested elements
    actual.each do |k,v|
      Cable.column_names.should include k
      #puts "#{k} => #{v}"
      v.keys.should include "relevance"
      v.keys.should include "options"
    end
  end
  
  it "gets relevance for each column based on the data" do
    # perform operation
    actual = Facet.calculate(Cable)
    
    describe "relevance calculations" do
      it "should have the correct number of options" do
        actual["type"]["options"].keys.sort.should eq(["flat","coax", "multi"].sort)
        actual["type"]["options"].count.should be 3
        actual["item_number"]["options"].count.should be 10
      end
      
      it "should omit empty options" do
        actual["number_pairs"]["options"].keys.should eq(["2"])
        actual["number_pairs"]["options"].count.should be 1
        actual["pitch"]["options"].count.should be 2
        actual["kevlar_core"]["options"].count.should be 1
      end
      
      describe "Normal Distribution (Gauss)" do
        
        describe "relevant results" do
          it "has 2 options 50-50%" do
            actual["part_type"]["relevance"].should be_within(0.3).of(10)
          end
          
          it "has 3 options 40-40-30%", :current => true  do
            actual["type"]["relevance"].should be_within(1.8).of(8)
          end
          
          it "has 1 option 50% and the rest NULL" do
            actual["number_pairs"]["relevance"].should be_within(1.8).of(5)
          end
          
        end
        
        it "should get relevance=0 with all NULL values" do
          actual["item_description"]["relevance"].should be_within(0.3).of(0)
        end
        
        it "should get relevance=0 with ALL values EQUAL" do
          actual["filename"]["relevance"].should be_within(0.3).of(0)  
          actual["level"]["relevance"].should be_within(0.3).of(0)  
          actual["conductor"]["relevance"].should be_within(0.3).of(0)  
          actual["wire_gauge"]["relevance"].should be_within(0.3).of(0)  
        end
        
        it "should have a relevance=0 when the values are ALL DIFFERENT" do
          actual["item_number"]["relevance"].should be_within(0.3).of(0) #be_close 0, 0.1
          actual["mfg_part_number"]["relevance"].should be_within(0.3).of(0) #be_close 0, 0.1
          actual["id"]["relevance"].should be_within(0.3).of(0) #be_close 0, 0.1
        end
              
        it "should have relevance intermediate" do
          actual["kevlar_core"]["relevance"].should be_within(0.3).of(5) #be_close 2, 0.1
        end
      end
      
      describe "show options count" do 
        it "should have the options count" do
          actual["type"]["options"].sort.should eq({"coax"=>4, "flat"=>4, "multi"=>2}.sort)
        end
      end
      
      describe "sorting" do
        it "should order by relevance" do
          actual.keys[0..2].should eq(%w|part_type type number_pairs|)
        end
      end
        
    end
  end  
end