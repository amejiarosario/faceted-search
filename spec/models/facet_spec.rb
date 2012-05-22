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
  
  describe "structure" do
    
    it "should have an array of objects" do
      actual = FacetProc.calculate(Cable.all)
      actual.each do |v|
        v.class.should eq(Facet)
      end      
    end
    
    it "should include column names from model and relevance" do
      actual = FacetProc.calculate(Cable.all) # FIXME should pass Cable.all, so it can be get facets from nested elements
      actual.each do |v|
        v.should be_respond_to "relevance"
        v.should be_respond_to "options"
        v.should be_respond_to "name"
      end
    end
   
    it "options should be an array" do
      actual = FacetProc.calculate(Cable.all)
      actual.each do |v|
        v.options.class.should eq(Array)
      end      
    end
  end
  
  describe "FacetProc" do
    it "should return an array of Facets with the column names"
    it "should sort the elements by relevance"
  end
  
  describe "Facet Objects" do
    it "should return the right number of options(flat,coax,multi) for the column 'type'"
    it "should have options count ('coax'=>4, 'flat'=>4, 'multi'=>2)"
    
    describe "calculate relevance" do
      it "should have relevance=0 +/- 1 with 100% different values (item_number, mfg_part_number, id)"
      it "should have relevance=10 +/- 1 with 50% different values (part_type, pitch)"
      it "should have relevance=0 +/- 1 with 0% different values (filename, level, conductor, wire_gauge)"
      
      it "should have relevance=0 with all null values (item_description)"
      it "should have relevance=8 +/-2 with 40-40-30 values (type)"
      it "should have relevance=5 +/- 2 with 50% values and other null (number_pairs)"
    end
  end
  
 end